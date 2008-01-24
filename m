From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: Re: [PATCH] pyalsa sequencer binding - 1/3
Date: Thu, 24 Jan 2008 05:27:46 -0300
Message-ID: <17eedd8a0801240027u7afa8fecn965957608467c87d@mail.gmail.com>
References: <17eedd8a0801080940i14edaef0l2f95e0eb6171cdaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 10DA12467E
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 09:27:47 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so210213pyg.36
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 00:27:47 -0800 (PST)
In-Reply-To: <17eedd8a0801080940i14edaef0l2f95e0eb6171cdaf@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi hackers again,

I'm sending second PATCH for pyalsa sequencer binding. Major new features:
- documentation of all python API
- more info on subscription listing
- subscribe/unsubscribe
- events (SeqEvent class)
- send/receive/modify events
- creating and managing queues

I've already ported some existing applications to python versions:
- aconnect.py
- aplaymidi.py
- aseqdump.py

There are also 3 samples of code seqtest[1-3].py included in the patch.



It's been a long and tedious work (16 days); please tell me anyhow to
improve and get this done and finished. Thanks again!!!

-------
Signed-off-by: Aldrin Martoq <amartoq@dcc.uchile.cl>

diff -r 02b11d9f243d pyalsa/alsaseq.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pyalsa/alsaseq.c	Thu Jan 24 05:18:40 2008 -0300
@@ -0,0 +1,3818 @@
+/*
+ *  Python binding for the ALSA library - sequencer
+ *  Copyright (c) 2008 by Aldrin Martoq <amartoq@dcc.uchile.cl>
+ *
+ *   This library is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU Lesser General Public License as
+ *   published by the Free Software Foundation; either version 2.1 of
+ *   the License, or (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include "Python.h"
+#include <alsa/asoundlib.h>
+#include <stdio.h>
+
+
+
+
+//////////////////////////////////////////////////////////////////////////////
+// some helper #define go here...
+//////////////////////////////////////////////////////////////////////////////
+
+/* temporal debug (will be deleted in last patch, promise!) */
+#if 1
+#define ddebug(x, args...) fprintf(stderr, x "\n",##args);
+#else
+#define ddebug(x, args...)
+#endif
+
+/* checks if passed argument is an integer and can't be deleted.
+   returns -1 if fails and raises TypeError or AttributeError. */
+#define SETCHECKPYINT(attr, val)				\
+  if (val == NULL) {						\
+    PyErr_SetString(PyExc_AttributeError,			\
+		    "attribute " attr " can't be deleted!");	\
+    return -1;							\
+  }								\
+  if (!PyInt_Check(val)) {					\
+    PyErr_SetString(PyExc_TypeError,				\
+		    "integer value expected for " attr);	\
+    return -1;							\
+  }
+
+/* checks if passed argument is a string and can't be deleted.
+   returns -1 if fails and raises TypeError or AttributeError. */
+#define SETCHECKPYSTR(attr, val)				\
+  if (val == NULL) {						\
+    PyErr_SetString(PyExc_AttributeError,			\
+		    "attribute " attr " can't be deleted!");	\
+    return -1;							\
+  }								\
+  if (!PyString_Check(val)) {					\
+    PyErr_SetString(PyExc_TypeError,				\
+		    "string value expected for " attr);		\
+    return -1;							\
+  }
+
+/* checks if passed argument is a list and can't be deleted.
+   returns -1 if fails and raises TypeError or AttributeError. */
+#define SETCHECKPYLIST(attr, val)				\
+  if (val == NULL) {						\
+    PyErr_SetString(PyExc_AttributeError,			\
+		    "attribute " attr " can't be deleted!");	\
+    return -1;							\
+  }								\
+  if (!PyList_Check(val)) {					\
+    PyErr_SetString(PyExc_TypeError,				\
+		    "list value expected for " attr);		\
+    return -1;							\
+  }
+
+/* frees only if pointer is not NULL. */
+#define FREECHECKED(name, pointer)		\
+  if (pointer != NULL) {			\
+    free(pointer);				\
+    pointer = NULL;				\
+  }
+
+/* raises SequencerError with the specified string */
+#define RAISESTR(str, args...)			\
+  PyErr_Format(SequencerError, str,##args);
+
+/* raises SequencerError with the specified string and appends
+   the alsaaudio error as string */
+#define RAISESND(ret, str, args...)					\
+  PyErr_Format(SequencerError, str ": %s",##args, snd_strerror(ret));
+
+/* the C variable of a constant dict */
+#define TDICT(subtype) _dictPYALSASEQ_CONST_##subtype
+
+/* the C enumeration of a constant dict */
+#define TTYPE(subtype) PYALSASEQ_CONST_##subtype
+
+/* defines constant dict by type */
+#define TCONSTDICT(subtype)			\
+  static PyObject * TDICT(subtype);
+
+/* adds constant dict to module */
+#define TCONSTDICTADD(module, subtype, name)				\
+  _dictPYALSASEQ_CONST_##subtype = PyDict_New();			\
+  if (TDICT(subtype) == NULL) {						\
+    return;								\
+  }									\
+  if (PyModule_AddObject(module, name, TDICT(subtype)) < 0) {		\
+    return;								\
+  }
+
+/* creates a typed constant and add it to the module and dictionary */
+#define TCONSTADD(module, subtype, name, value) {			\
+    PyObject *tmp =							\
+      Constant_create(name, value, TTYPE(subtype));			\
+    if (tmp == NULL) {							\
+      return;								\
+    }									\
+    if (PyModule_AddObject(module, name, tmp) < 0) {			\
+      return;								\
+    }									\
+    PyDict_SetItem(TDICT(subtype), PyInt_FromLong(value), tmp);		\
+  }
+
+#define TCONSTRETURN(subtype, value) {			\
+    PyObject *key = PyInt_FromLong(value);		\
+    ConstantObject *constantObject = (ConstantObject *)	\
+      PyDict_GetItem(TDICT(subtype), key);		\
+    if (constantObject == NULL) {			\
+      return key;					\
+    } else {						\
+      Py_DECREF(key);					\
+      Py_INCREF(constantObject);			\
+      return (PyObject *)constantObject;		\
+    }							\
+  }
+
+#define TCONSTASSIGN(subtype, value, param) {		\
+    PyObject *key = PyInt_FromLong(value);		\
+    ConstantObject *constantObject = (ConstantObject *) \
+      PyDict_GetItem(TDICT(subtype), key);		\
+    if (constantObject == NULL) {			\
+      param = key;					\
+    } else {						\
+      Py_DECREF(key);					\
+      Py_INCREF(constantObject);			\
+      param = (PyObject *)constantObject;		\
+    }							\
+  }
+
+
+/* num protocol support for binary Constant operations */
+#define NUMPROTOCOL2(name, oper)				\
+  static PyObject *						\
+  Constant_##name (PyObject *v, PyObject *w) {			\
+    int type = 0;						\
+    long val = 0;						\
+    /* both have to be a int */					\
+    if (!PyInt_Check(v) || !PyInt_Check(w)) {			\
+      Py_INCREF(Py_NotImplemented);				\
+      return Py_NotImplemented;					\
+    }								\
+    val = PyInt_AS_LONG(v) oper PyInt_AS_LONG(w);		\
+    /* always asume left will be the type */			\
+    if (PyObject_TypeCheck(v, &ConstantType)) {			\
+      type = ((ConstantObject *) v)->type;			\
+    } else if (PyObject_TypeCheck(w, &ConstantType)) {		\
+      type = ((ConstantObject *) w)->type;			\
+    }								\
+    PyObject *self = Constant_create(#oper, val, type);		\
+    return self;						\
+  }
+
+/* num protocol support for unary Constant operations */
+#define NUMPROTOCOL1(name, oper)			\
+  static PyObject *					\
+  Constant_##name (PyObject *v) {			\
+    int type = 0;					\
+    long val = 0;					\
+    if (!PyInt_Check(v)) {				\
+      Py_INCREF(Py_NotImplemented);			\
+      return Py_NotImplemented;				\
+    }							\
+    val = oper PyInt_AS_LONG(v);			\
+    if (PyObject_TypeCheck(v, &ConstantType)) {		\
+      type = ((ConstantObject *) v)->type;		\
+    }							\
+    PyObject *self = Constant_create(#oper, val, type); \
+    return self;					\
+  }
+
+/* sets the object into the dict */
+#define SETDICTOBJ(name, object)		\
+  PyDict_SetItemString(dict, name, object)
+
+/* sets a integer into the dict */
+#define SETDICTINT(name, value)					\
+  PyDict_SetItemString(dict, name, PyInt_FromLong(value))
+
+/* sets note info dict (used by SeqEvent_get_data) */
+#define SETDICT_NOTE3 {					\
+    snd_seq_ev_note_t *data = &(event->data.note);	\
+    SETDICTINT("note.channel", data->channel);		\
+    SETDICTINT("note.note", data->note);		\
+    SETDICTINT("note.velocity", data->velocity);	\
+  }
+
+/* sets note info dict (used by SeqEvent_get_data) */
+#define SETDICT_NOTE5 {						\
+    snd_seq_ev_note_t *data = &(event->data.note);		\
+    SETDICTINT("note.channel", data->channel);			\
+    SETDICTINT("note.note", data->note);			\
+    SETDICTINT("note.velocity", data->velocity);		\
+    SETDICTINT("note.off_velocity", data->off_velocity);	\
+    SETDICTINT("note.duration", data->duration);		\
+  }
+
+
+
+/* sets control info dict (used by SeqEvent_get_data) */
+#define SETDICT_CTRL1 {					\
+    snd_seq_ev_ctrl_t *data = &(event->data.control);	\
+    SETDICTINT("control.value", data->value);		\
+  }
+
+/* sets control info dict (used by SeqEvent_get_data) */
+#define SETDICT_CTRL2 {					\
+    snd_seq_ev_ctrl_t *data = &(event->data.control);	\
+    SETDICTINT("control.channel", data->channel);	\
+    SETDICTINT("control.value", data->value);		\
+  }
+
+/* sets control info dict (used by SeqEvent_get_data) */
+#define SETDICT_CTRL3 {					\
+    snd_seq_ev_ctrl_t *data = &(event->data.control);	\
+    SETDICTINT("control.channel", data->channel);	\
+    SETDICTINT("control.param", data->param);		\
+    SETDICTINT("control.value", data->value);		\
+  }
+
+/* sets queue info dict (used by SeqEvent_get_data) */
+#define SETDICT_QUEU1 {						\
+    snd_seq_ev_queue_control_t *data = &(event->data.queue);	\
+    SETDICTINT("queue.queue", data->queue);			\
+  }
+
+/* sets addr info dict (used by SeqEvent_get_data) */
+#define SETDICT_ADDR1 {				\
+    snd_seq_addr_t *data = &(event->data.addr); \
+    SETDICTINT("addr.client", data->client);	\
+  }
+
+/* sets addr info dict (used by SeqEvent_get_data) */
+#define SETDICT_ADDR2 {				\
+    snd_seq_addr_t *data = &(event->data.addr); \
+    SETDICTINT("addr.client", data->client);	\
+    SETDICTINT("addr.port", data->port);	\
+  }
+
+/* sets connect info dict (used by SeqEvent_get_data) */
+#define SETDICT_CONN4 {						\
+    snd_seq_connect_t *data = &(event->data.connect);		\
+    SETDICTINT("connect.sender.client", data->sender.client);	\
+    SETDICTINT("connect.sender.port", data->sender.port);	\
+    SETDICTINT("connect.dest.client", data->dest.client);	\
+    SETDICTINT("connect.dest.port", data->dest.port);		\
+  }
+
+/* sets result info dict (used by SeqEvent_get_data) */
+#define SETDICT_RESU2 {					\
+    snd_seq_result_t *data = &(event->data.result);	\
+    SETDICTINT("result.event", data->event);		\
+    SETDICTINT("result.result", data->result);		\
+  }
+
+/* sets ext info dict (used by SeqEvent_get_data) */
+#define SETDICT_EXT {					\
+    snd_seq_ev_ext_t *data = &(event->data.ext);	\
+    PyObject *list = PyList_New(data->len);		\
+    int i = 0;						\
+    unsigned char *t = (unsigned char *) data->ptr;	\
+    for (i = 0; i < data->len; i++) {			\
+      PyList_Append(list, PyInt_FromLong(t[i]));	\
+    }							\
+    SETDICTOBJ("ext", list);				\
+  }
+
+/* gets integer from python param */
+#define GETDICTINT(name, param) {					\
+    PyObject *value = PyDict_GetItemString(dict, name);			\
+    if (value != NULL) {						\
+      if (!PyInt_Check(value)) {					\
+	PyErr_SetString(PyExc_TypeError, name " must be a integer");	\
+	return NULL;							\
+      }									\
+      param = PyInt_AsLong(value);					\
+    }									\
+  }
+
+/* gets float from python param */
+#define GETDICTFLOAT(name, param1, param2) {			\
+    PyObject *value = PyDict_GetItemString(dict, name);		\
+    if (value != NULL) {					\
+      if (PyInt_Check(value)) {					\
+	param2 = 0;						\
+	param1 = PyInt_AsLong(value);				\
+      } else if (PyFloat_Check(value)) {			\
+	double d = PyFloat_AsDouble(value);			\
+	unsigned int i = d;					\
+	d -= i;							\
+	param2 = d * 1000000;					\
+	param1 = i;						\
+      } else {							\
+	PyErr_SetString(PyExc_TypeError,			\
+			name " must be a integer or float");	\
+	return NULL;						\
+      }								\
+    }								\
+  }
+
+/* gets ext data from python list */
+#define GETDICTEXT(name) {						\
+    PyObject *list = PyDict_GetItemString(dict, name);			\
+    if (list != NULL) {							\
+      if (!PyList_Check(list)) {					\
+	PyErr_SetString(PyExc_TypeError,				\
+			name " must be a list of integers");		\
+	return NULL;							\
+      }									\
+      FREECHECKED("buff", self->buff);					\
+      int len = PyList_Size(list);					\
+      self->event->data.ext.len = len;					\
+      if (len > 0) {							\
+	int i;								\
+	self->buff = malloc(len);					\
+	for (i = 0; i < len; i++) {					\
+	  PyObject *item = PyList_GetItem(list, i);			\
+	  if (!PyInt_Check(item)) {					\
+	    PyErr_SetString(PyExc_TypeError,				\
+			    name " must be a list of integers");	\
+	    return NULL;						\
+	  }								\
+	  self->buff[i] = PyInt_AsLong(item);				\
+	}								\
+      }									\
+    }									\
+  }
+
+
+
+
+
+
+//////////////////////////////////////////////////////////////////////////////
+// alsaseq.Constant implementation
+//////////////////////////////////////////////////////////////////////////////
+
+/* alsaseq.Constant->type enumeration */
+enum {
+  PYALSASEQ_CONST_STREAMS,
+  PYALSASEQ_CONST_MODE,
+  PYALSASEQ_CONST_QUEUE,
+  PYALSASEQ_CONST_CLIENT_TYPE,
+  PYALSASEQ_CONST_PORT_CAP,
+  PYALSASEQ_CONST_PORT_TYPE,
+  PYALSASEQ_CONST_EVENT_TYPE,
+  PYALSASEQ_CONST_EVENT_TIMESTAMP,
+  PYALSASEQ_CONST_EVENT_TIMEMODE,
+  PYALSASEQ_CONST_ADDR_CLIENT,
+  PYALSASEQ_CONST_ADDR_PORT,
+};
+
+// constants dictionaries
+
+TCONSTDICT(STREAMS);
+TCONSTDICT(MODE);
+TCONSTDICT(QUEUE);
+TCONSTDICT(CLIENT_TYPE);
+TCONSTDICT(PORT_CAP);
+TCONSTDICT(PORT_TYPE);
+TCONSTDICT(EVENT_TYPE);
+TCONSTDICT(EVENT_TIMESTAMP);
+TCONSTDICT(EVENT_TIMEMODE);
+TCONSTDICT(ADDR_CLIENT);
+TCONSTDICT(ADDR_PORT);
+
+
+/** alsaseq.Constant __doc__ */
+const char Constant__doc__ [] =
+  "Constant() -> Constant object\n"
+  "\n"
+  "Represents one of the many integer constants from the\n"
+  "libasound sequencer API.\n"
+  "\n"
+  "This class serves the following purposes:\n"
+  "  a. wrap the SND_SEQ* constants to a python int;\n"
+  "  b. provide a string representation of the constant;\n"
+  "\n"
+  "For a), this class is a subclass of the python int. Example:\n"
+  "  >>> import alsaseq\n"
+  "  >>> print alsaseq.SEQ_EVENT_NOTE\n"
+  "  5\n"
+  "  >>> event = alsaseq.SeqEvent(alsaseq.SEQ_EVENT_NOTE)\n"
+  "  >>> print event.queue\n"
+  "  253\n"
+  "  >>> print event.dest\n"
+  "  (0, 0)\n"
+  "\n"
+  "For b), you can get the name of the constant by calling the appropiate\n"
+  "method (__str__ or __repr__). Example:\n"
+  "  >>> print str(event.queue), repr(event.queue)\n"
+  "  SEQ_QUEUE_DIRECT SEQ_QUEUE_DIRECT(0xfd)\n"
+  "  >>> print str(event.dest)\n"
+  "  (SEQ_CLIENT_SYSTEM(0x0), SEQ_PORT_SYSTEM_TIMER(0x0))\n"
+  "\n"
+  "This class implements some of the bitwise operations from the\n"
+  "Python number protocol."
+  ;
+
+/** alsaseq.Constant object structure type */
+typedef struct {
+  PyObject_HEAD
+  ;
+
+  /* value of constant */
+  unsigned int value;
+  /* name of constant */
+  const char *name;
+  /* type of constant */
+  int type;
+} ConstantObject;
+
+/** alsaseq.Constant type (initialized later...) */
+static PyTypeObject ConstantType;
+
+/** alsaseq.Constant internal create */
+static PyObject *
+Constant_create(const char *name, long value, int type) {
+  ConstantObject *self = PyObject_New(ConstantObject, &ConstantType);
+
+  if (self == NULL) {
+    return NULL;
+  }
+
+  self->value = value;
+  self->name = name;
+  self->type = type;
+
+  return (PyObject *)self;
+}
+
+/** alsaseq.Constant tp_repr */
+static PyObject *
+Constant_repr(ConstantObject *self) {
+  return PyString_FromFormat("%s(0x%x)",
+			     self->name,
+			     self->value);
+}
+
+/** alsaseq.Constant tp_str */
+static PyObject *
+Constant_str(ConstantObject *self) {
+  return PyString_FromFormat("%s",
+			     self->name);
+}
+
+/** alsaseq.Constant Number protocol support (note: not all ops supported) */
+NUMPROTOCOL2(Add, +)
+NUMPROTOCOL2(Subtract, -)
+NUMPROTOCOL2(Xor, ^)
+NUMPROTOCOL2(Or, |)
+NUMPROTOCOL2(And, &)
+NUMPROTOCOL1(Invert, ~)
+
+/** alsaseq.Constant number protocol methods */
+static PyNumberMethods Constant_as_number = {
+ nb_add: (binaryfunc)Constant_Add,
+ nb_subtract: (binaryfunc)Constant_Subtract,
+ nb_xor: (binaryfunc)Constant_Xor,
+ nb_or: (binaryfunc)Constant_Or,
+ nb_and: (binaryfunc)Constant_And,
+ nb_invert: (unaryfunc)Constant_Invert
+};
+
+/** alsaseq.Constant type */
+static PyTypeObject ConstantType = {
+  PyObject_HEAD_INIT(NULL)
+  tp_name: "alsaseq.Constant",
+  tp_base: &PyInt_Type,
+  tp_basicsize: sizeof(ConstantObject),
+  tp_flags:
+  Py_TPFLAGS_HAVE_GETCHARBUFFER
+  | Py_TPFLAGS_HAVE_CLASS
+  | Py_TPFLAGS_CHECKTYPES,
+  tp_doc: Constant__doc__,
+  tp_as_number: &Constant_as_number,
+  tp_free: PyObject_Del,
+  tp_str: (reprfunc)Constant_str,
+  tp_repr: (reprfunc)Constant_repr
+};
+
+
+
+
+
+//////////////////////////////////////////////////////////////////////////////
+// alsaseq.SequencerError implementation
+//////////////////////////////////////////////////////////////////////////////
+
+/** alsaseq.SequencerError instance (initialized in initalsaseq) */
+static PyObject *SequencerError;
+
+
+
+
+
+//////////////////////////////////////////////////////////////////////////////
+// alsaseq.SeqEvent implementation
+//////////////////////////////////////////////////////////////////////////////
+
+/** alsaseq.SeqEvent __doc__ */
+const char SeqEvent__doc__ [] =
+  "SeqEvent(type[, timestamp[,timemode]]) -> SeqEvent object\n"
+  "\n"
+  "Creates an Alsa Sequencer Event object. The type must be one of the\n"
+  "alsaseq.SEQ_EVENT_* constants. The timestamp specifies if tick (midi)\n"
+  "or real time is used, must be alsaseq.SEQ_TIME_STAMP_TICK or\n"
+  "alsaseq.SEQ_TIME_STAMP_REAL. The timemode specifies if the time will\n"
+  "be absolute or relative, must be alsaseq.SEQ_TIME_MODE_ABS or\n"
+  "alsaseq.SEQ_TIME_MODE_REL.\n"
+  "\n"
+  "The timestamp and timemode defaults to SEQ_TIME_STAMP_TICK and\n"
+  "SEQ_TIME_MODE_ABS when they are not specified.\n"
+  "\n"
+  "SeqEvent objects are received or sent using a Sequencer object. The\n"
+  "data of the event can be set or retrieved using the set_data() or\n"
+  "get_data() methods; both use a dictionary. The rest of properties of\n"
+  "a SeqEvent can be accesed and changed using the SeqEvent attributes.\n"
+  "\n"
+  "The attributes and defaults values are:\n"
+  "type -- event type.\n"
+  "timestamp -- tick(midi) or real(nanoseconds). Default:
SEQ_TIME_STAMP_TICK.\n"
+  "timemode -- relative or absolute. Default: SEQ_TIME_MODE_ABS.\n"
+  "queue -- queue id. Default: SEQ_QUEUE_DIRECT\n"
+  "time -- time of this event. Default: 0.\n"
+  "source -- source address tuple (client,port). Default: (0, 0).\n"
+  "dest -- dest address tuple (client, port). Default: (0, 0).\n"
+  "\n"
+  "There are dictionaries available as attributes, that contains\n"
+  "alsaseq.SEQ* constants that can be used for each attribute:\n"
+  "_dtype -- event type constants.\n"
+  "_dtimestamp -- event timestamp constants.\n"
+  "_dtimemode -- event timemode constants.\n"
+  "_dqueue -- queue id's.\n"
+  "_dclient -- client address (for source an dest).\n"
+  "_dport -- port address (for source an dest).\n"
+  ;
+
+/** alsaseq.SeqEvent object structure type */
+typedef struct {
+  PyObject_HEAD
+  ;
+
+  /* alsa event */
+  snd_seq_event_t *event;
+
+  /* pointer copied/created from/for variable length events */
+  unsigned char *buff;
+} SeqEventObject;
+
+/** alsaseq.SeqEvent type (initialized later...) */
+static PyTypeObject SeqEventType;
+
+/** internal use: set type and update flags based on event type */
+static int
+_SeqEvent_set_type(SeqEventObject *self,
+			      long type) {
+  self->event->type = type;
+
+  /* clean previous buff... */
+  FREECHECKED("buff", self->buff);
+  memset(&(self->event->data), '\0', sizeof(self->event->data));
+
+  /* update flags */
+  if (snd_seq_ev_is_variable_type(self->event)) {
+    snd_seq_ev_set_variable(self->event, 0, NULL);
+  } else if (snd_seq_ev_is_varusr_type(self->event)) {
+    snd_seq_ev_set_varusr(self->event, 0, NULL);
+  } else if (snd_seq_ev_is_fixed_type(self->event)) {
+    snd_seq_ev_set_fixed(self->event);
+  } else {
+    PyErr_SetString(PyExc_ValueError,
+		    "Invalid value for type; "
+		    "use one of alsaseq.SEQ_EVENT_* constants.");
+    return -1;
+  }
+
+  return 0;
+}
+
+/** internal use: set timestamp flag */
+static int
+_SeqEvent_set_timestamp(SeqEventObject *self,
+				   long timestamp) {
+  if (timestamp == SND_SEQ_TIME_STAMP_TICK) {
+    self->event->flags &= ~(SND_SEQ_TIME_STAMP_MASK);
+    self->event->flags |= SND_SEQ_TIME_STAMP_TICK;
+  } else if (timestamp == SND_SEQ_TIME_STAMP_REAL) {
+    self->event->flags &= ~(SND_SEQ_TIME_STAMP_MASK);
+    self->event->flags |= SND_SEQ_TIME_STAMP_REAL;
+  } else {
+    PyErr_SetString(PyExc_ValueError,
+		    "Invalid value for timestamp; "
+		    "use alsaseq.SEQ_TIME_STAMP_TICK or "
+		    "alsaseq.SEQ_TIME_STAMP_REAL.");
+    return -1;
+  }
+
+  return 0;
+}
+
+/** internal use: set timemode flag */
+static int
+_SeqEvent_set_timemode(SeqEventObject *self,
+				  long timemode) {
+  if (timemode == SND_SEQ_TIME_MODE_ABS) {
+    self->event->flags &= ~(SND_SEQ_TIME_MODE_MASK);
+    self->event->flags |= SND_SEQ_TIME_MODE_ABS;
+  } else if (timemode == SND_SEQ_TIME_MODE_REL) {
+    self->event->flags &= ~(SND_SEQ_TIME_MODE_MASK);
+    self->event->flags |= SND_SEQ_TIME_MODE_REL;
+  } else {
+    PyErr_SetString(PyExc_ValueError,
+		    "Invalid value for timemode; "
+		    "use alsaseq.SEQ_TIME_MODE_ABS or "
+		    "alsaseq.SEQ_TIME_MODE_REL.");
+    return -1;
+  }
+
+  return 0;
+}
+
+
+/** alsaseq.SeqEvent tp_init */
+static int
+SeqEvent_init(SeqEventObject *self,
+			 PyObject *args,
+			 PyObject *kwds) {
+  int type = 0;
+  int timestamp = SND_SEQ_TIME_STAMP_TICK;
+  int timemode = SND_SEQ_TIME_MODE_ABS;
+  char *kwlist [] = {"type", "timestamp", "timemode", NULL};
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "i|ii", kwlist, &type,
+				   &timestamp, &timemode)) {
+    return -1;
+  }
+
+  if (_SeqEvent_set_type(self, type) !=0 ) {
+    return -1;
+  }
+  if (_SeqEvent_set_timestamp(self, timestamp) != 0) {
+    return -1;
+  }
+  if (_SeqEvent_set_timemode(self, timemode) != 0) {
+    return -1;
+  }
+
+  snd_seq_ev_set_direct(self->event);
+  snd_seq_ev_set_subs(self->event);
+
+  return 0;
+}
+
+
+
+/** internal use: create a alsaseq.SeqEvent from a snd_seq_event_t structure */
+static PyObject *
+SeqEvent_create(snd_seq_event_t *event) {
+  SeqEventObject *self = PyObject_New(SeqEventObject, &SeqEventType);
+
+  if (self == NULL) {
+    return NULL;
+  }
+
+  self->event = malloc(sizeof(snd_seq_event_t));
+  if (self->event == NULL) {
+    PyObject_Del(self);
+    return PyErr_NoMemory();
+  }
+
+  memcpy(self->event, event, sizeof(snd_seq_event_t));
+  if (snd_seq_ev_is_variable_type(self->event)) {
+    self->buff = malloc(self->event->data.ext.len);
+    memcpy(self->event->data.ext.ptr, self->buff, self->event->data.ext.len);
+    self->event->data.ext.ptr = self->buff;
+  } else {
+    self->buff = NULL;
+  }
+
+  return (PyObject *) self;
+}
+
+/** alsaseq.SeqEvent tp_new */
+static PyObject *
+SeqEvent_new(PyTypeObject *type,
+	     PyObject *args,
+	     PyObject *kwds) {
+  SeqEventObject *self;
+
+  self = (SeqEventObject *)type->tp_alloc(type, 0);
+
+  self->event = malloc(sizeof(snd_seq_event_t));
+  if (self->event == NULL) {
+    type->tp_free(self);
+    return PyErr_NoMemory();
+  }
+  snd_seq_ev_clear(self->event);
+  self->buff = NULL;
+
+  return (PyObject *) self;
+}
+
+/** alsaseq.SeqEvent tp_dealloc */
+static void
+SeqEvent_dealloc(SeqEventObject *self) {
+  FREECHECKED("event", self->event);
+  FREECHECKED("buff", self->buff);
+
+  self->ob_type->tp_free(self);
+}
+
+/** alsaseq.SeqEvent type attribute: __doc__ */
+const char SeqEvent_type__doc__ [] =
+  "type -> Constant object\n"
+  "\n"
+  "The type of this alsaseq.SeqEvent; Use one of the\n"
+  "alsaseq.SEQ_EVENT_* constants.\n\n"
+  "Note: changing a SeqEvent type will *ERASE* AND *CLEAN* its data!!"
+  ;
+
+/** alsaseq.SeqEvent type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_get_type(SeqEventObject *self) {
+  TCONSTRETURN(EVENT_TYPE, self->event->type);
+}
+
+/** alsaseq.SeqEvent type attribute: tp_getset setter() */
+static int
+SeqEvent_set_type(SeqEventObject *self,
+		  PyObject *val) {
+  SETCHECKPYINT("type", val);
+
+  return _SeqEvent_set_type(self, PyInt_AsLong(val));
+}
+
+/** alsaseq.SeqEvent tag attribute: __doc__ */
+const char SeqEvent_tag__doc__ [] =
+  "tag -> int\n"
+  "\n"
+  "The tag of this alsaseq.SeqEvent (range:0-255)."
+  ;
+
+/** alsaseq.SeqEvent tag attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_get_tag(SeqEventObject *self) {
+  return PyInt_FromLong(self->event->tag);
+}
+
+/** alsaseq.SeqEvent tag attribute: tp_getset setter() */
+static int
+SeqEvent_set_tag(SeqEventObject *self,
+		 PyObject *val) {
+  long tag;
+
+  SETCHECKPYINT("tag", val);
+
+  tag = PyInt_AsLong(val);
+  if (tag < 0 || tag > 255) {
+    PyErr_Format(PyExc_ValueError,
+		 "invalid value '%ld'; allowed range: 0 - 255",
+		 tag);
+    return -1;
+  }
+  self->event->tag = tag;
+  return 0;
+}
+
+/** alsaseq.seqEvent timestamp attribute: __doc__ */
+const char SeqEvent_timestamp__doc__ [] =
+  "timestamp -> Constant object\n"
+  "\n"
+  "The time stamp flag of this alsaseq.SeqEvent;\n"
+  "use alsaseq.SEQ_TIME_STAMP_TICK or alsaseq.SEQ_TIME_STAMP_REAL."
+  ;
+
+/** alsaseq.SeqEvent timestamp attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_get_timestamp(SeqEventObject *self) {
+  if (snd_seq_ev_is_tick(self->event)) {
+    TCONSTRETURN(EVENT_TIMESTAMP, SND_SEQ_TIME_STAMP_TICK);
+  } else if (snd_seq_ev_is_real(self->event)) {
+    TCONSTRETURN(EVENT_TIMESTAMP, SND_SEQ_TIME_STAMP_REAL);
+  }
+
+  /* should never get here ... */
+  return NULL;
+}
+
+/** alsaseq.SeqEvent timestamp attribute: tp_getset setter() */
+static int
+SeqEvent_set_timestamp(SeqEventObject *self,
+		       PyObject *val) {
+  SETCHECKPYINT("timestamp", val);
+
+  return _SeqEvent_set_timestamp(self, PyInt_AsLong(val));
+}
+
+/** alsaseq.SeqEvent timemode attribute: __doc__ */
+const char SeqEvent_timemode__doc__ [] =
+  "timemode -> Constant object\n"
+  "\n"
+  "The time mode flag of this alsaseq.SeqEvent;\n"
+  "use alsaseq.SEQ_TIME_MODE_ABS or alsaseq.SEQ_TIME_MODE_REL."
+  ;
+
+/** alsaseq.SeqEvent timemode attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_get_timemode(SeqEventObject *self) {
+  if (snd_seq_ev_is_abstime(self->event)) {
+    TCONSTRETURN(EVENT_TIMEMODE, SND_SEQ_TIME_MODE_ABS);
+  } else if (snd_seq_ev_is_reltime(self->event)) {
+    TCONSTRETURN(EVENT_TIMEMODE, SND_SEQ_TIME_MODE_REL);
+  }
+
+  /* should never get here ... */
+  return NULL;
+}
+
+/** alsaseq.SeqEvent timemode attribute: tp_getset setter() */
+static int
+SeqEvent_set_timemode(SeqEventObject *self,
+		      PyObject *val) {
+  SETCHECKPYINT("timemode", val);
+
+  return _SeqEvent_set_timemode(self, PyInt_AsLong(val));
+}
+
+/** alsaseq.SeqEvent queue attribute: __doc__ */
+const char SeqEvent_queue__doc__ [] =
+  "queue -> int\n"
+  "\n"
+  "The send queue id of this alsaseq.SeqEvent."
+  ;
+
+/** alsaseq.SeqEvent queue: tp_getset getter() */
+static PyObject *
+SeqEvent_get_queue(SeqEventObject *self) {
+  TCONSTRETURN(QUEUE, self->event->queue);
+}
+
+/** alsaseq.SeqEvent queue attribute: tp_getset setter() */
+static int
+SeqEvent_set_queue(SeqEventObject *self,
+		   PyObject *val) {
+  SETCHECKPYINT("queue", val);
+
+  self->event->queue = PyInt_AsLong(val);
+  return 0;
+}
+
+/** alsaseq.SeqEvent time attribute: __doc__ */
+const char SeqEvent_time__doc__ [] =
+  "time -> int or float\n"
+  "\n"
+  "The send time of this alsaseq.SeqEvent.\n"
+  "If the timestamp of the SeqEvent is SEQ_TIME_STAMP_TICK, an\n"
+  "integer value is used which represents the midi tick time; \n"
+  "if the timestamp is SEQ_TIME_STAMP_REAL, a float value is used\n"
+  "which represents seconds the same way Python time module.\n"
+  ;
+
+/** alsaseq.SeqEvent time attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_get_time(SeqEventObject *self) {
+  if (snd_seq_ev_is_real(self->event)) {
+    double time = self->event->time.time.tv_sec;
+    time += self->event->time.time.tv_nsec * 0.000001;
+    return PyFloat_FromDouble(time);
+  } else if (snd_seq_ev_is_tick(self->event)) {
+    long tick = self->event->time.tick;
+    return PyInt_FromLong(tick);
+  }
+
+  /* should never get here... */
+  return NULL;
+}
+
+/** alsaseq.SeqEvent time attribute: tp_getset setter() */
+static int
+SeqEvent_set_time(SeqEventObject *self,
+		  PyObject *val) {
+  int is_int = PyInt_Check(val);
+  int is_float = PyFloat_Check(val);
+
+  if (!(is_int || is_float)) {
+    PyErr_Format(PyExc_TypeError,
+		 "integer or float expected");
+    return -1;
+  }
+
+  if (snd_seq_ev_is_real(self->event)) {
+    if (is_int) {
+      double time = PyInt_AsLong(val);
+      self->event->time.time.tv_sec = time;
+      self->event->time.time.tv_nsec = 0;
+    } else {
+      double time = PyFloat_AsDouble(val);
+      self->event->time.time.tv_sec = (unsigned int)time;
+      time -= self->event->time.time.tv_sec;
+      self->event->time.time.tv_nsec = time * 1000000;
+    }
+  } else if (snd_seq_ev_is_tick(self->event)) {
+    if (is_int) {
+      self->event->time.tick = PyInt_AsLong(val);
+    } else {
+      self->event->time.tick = PyFloat_AsDouble(val);
+    }
+  } else {
+    /* should never get here... */
+    return -1;
+  }
+  return 0;
+}
+
+/** alsaseq.SeqEvent source attribute: __doc __ */
+const char SeqEvent_source__doc__ [] =
+  "source -> tuple (client_id, port_id)\n"
+  "\n"
+  "Tuple representing the send source address of this alsaseq.SeqEvent.\n"
+  "The tuple is (client_id, port_id). If the client or port id are known,\n"
+  "the appropiate constant may be used, otherwise integers are expected."
+  ;
+
+/** alsaseq.SeqEvent source attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_get_source(SeqEventObject *self) {
+  int source_client = self->event->source.client;
+  int source_port = self->event->source.port;
+  PyObject *client, *port;
+  PyObject *tuple = PyTuple_New(2);
+
+  TCONSTASSIGN(ADDR_CLIENT, source_client, client);
+  TCONSTASSIGN(ADDR_PORT, source_port, port);
+
+  PyTuple_SetItem(tuple, 0, client);
+  PyTuple_SetItem(tuple, 1, port);
+
+  return tuple;
+}
+
+/** alsaseq.SeqEvent source attribute: tp_getset setter() */
+static int
+SeqEvent_set_source(SeqEventObject *self,
+		    PyObject *val) {
+  PyObject *client;
+  PyObject *port;
+
+  if (!PyTuple_Check(val) || PyTuple_Size(val) != 2) {
+    PyErr_SetString(PyExc_TypeError, "expected tuple (client,port)");
+    return -1;
+  }
+
+  client = PyTuple_GetItem(val, 0);
+  port = PyTuple_GetItem(val, 1);
+  SETCHECKPYINT("source client", client);
+  SETCHECKPYINT("source port", port);
+
+  self->event->source.client = PyInt_AsLong(client);
+  self->event->source.port = PyInt_AsLong(port);
+
+  return 0;
+}
+
+/** alsaseq.SeqEvent dest attribute: __doc __ */
+const char SeqEvent_dest__doc__ [] =
+  "dest -> tuple (client_id, port_id)\n"
+  "\n"
+  "Tuple representing the destination address of this alsaseq.SeqEvent.\n"
+  "The tuple is (client_id, port_id). If the client or port id are known,\n"
+  "the appropiate constant may be used, otherwise integers are expected."
+  ;
+
+/** alsaseq.SeqEvent dest attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_get_dest(SeqEventObject *self) {
+  int dest_client = self->event->dest.client;
+  int dest_port = self->event->dest.port;
+  PyObject *client, *port;
+  PyObject *tuple = PyTuple_New(2);
+
+  TCONSTASSIGN(ADDR_CLIENT, dest_client, client);
+  TCONSTASSIGN(ADDR_PORT, dest_port, port);
+
+  PyTuple_SetItem(tuple, 0, client);
+  PyTuple_SetItem(tuple, 1, port);
+
+  return tuple;
+}
+
+/** alsaseq.SeqEvent dest attribute: tp_getset setter() */
+static int
+SeqEvent_set_dest(SeqEventObject *self,
+		  PyObject *val) {
+  PyObject *client;
+  PyObject *port;
+
+  if (!PyTuple_Check(val) || PyTuple_Size(val) != 2) {
+    PyErr_SetString(PyExc_TypeError, "expected tuple (client,port)");
+    return -1;
+  }
+
+  client = PyTuple_GetItem(val, 0);
+  port = PyTuple_GetItem(val, 1);
+  SETCHECKPYINT("dest client", client);
+  SETCHECKPYINT("dest port", port);
+
+  self->event->dest.client = PyInt_AsLong(client);
+  self->event->dest.port = PyInt_AsLong(port);
+
+  return 0;
+}
+
+/** alsaseq.SeqEvent is_result_type attribute: __doc__ */
+const char SeqEvent_is_result_type__doc__ [] =
+  "is_result_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type result (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+
+/** alsaseq.SeqEvent is_result_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_result_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_result_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_note_type attribute: __doc__ */
+const char SeqEvent_is_note_type__doc__ [] =
+  "is_note_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type note (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_note_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_note_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_note_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_control_type attribute: __doc__ */
+const char SeqEvent_is_control_type__doc__ [] =
+  "is_control_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type control (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_note_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_control_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_control_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_channel_type attribute: __doc__ */
+const char SeqEvent_is_channel_type__doc__ [] =
+  "is_channel_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type channel (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_channel_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_channel_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_channel_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_queue_type attribute: __doc__ */
+const char SeqEvent_is_queue_type__doc__ [] =
+  "is_queue_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is a queue event (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_queue_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_queue_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_queue_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_message_type attribute: __doc__ */
+const char SeqEvent_is_message_type__doc__ [] =
+  "is_message_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type message (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_message_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_message_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_message_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_subscribe_type attribute: __doc__ */
+const char SeqEvent_is_subscribe_type__doc__ [] =
+  "is_subscribe_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type subscribe (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_subscribe_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_subscribe_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_subscribe_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_sample_type attribute: __doc__ */
+const char SeqEvent_is_sample_type__doc__ [] =
+  "is_sample_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type sample (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_sample_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_sample_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_sample_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_user_type attribute: __doc__ */
+const char SeqEvent_is_user_type__doc__ [] =
+  "is_user_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type user (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_user_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_user_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_user_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_instr_type attribute: __doc__ */
+const char SeqEvent_is_instr_type__doc__ [] =
+  "is_instr_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type instr (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_instr_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_instr_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_instr_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_fixed_type attribute: __doc__ */
+const char SeqEvent_is_fixed_type__doc__ [] =
+  "is_fixed_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type fixed (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_fixed_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_fixed_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_fixed_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_variable_type attribute: __doc__ */
+const char SeqEvent_is_variable_type__doc__ [] =
+  "is_variable_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type variable (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_variable_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_variable_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_variable_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_varusr_type attribute: __doc__ */
+const char SeqEvent_is_varusr_type__doc__ [] =
+  "is_message_type -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is of type varusr (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_varusr_type attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_varusr_type(SeqEventObject *self) {
+  if (snd_seq_ev_is_varusr_type(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_reserved attribute: __doc__ */
+const char SeqEvent_is_reserved__doc__ [] =
+  "is_reserved -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is reserved (True) or not (False).\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_reserved attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_reserved(SeqEventObject *self) {
+  if (snd_seq_ev_is_reserved(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_prior attribute: __doc__ */
+const char SeqEvent_is_prior__doc__ [] =
+  "is_prior -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is prior (True) or not (False).\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_prior attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_prior(SeqEventObject *self) {
+  if (snd_seq_ev_is_prior(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_fixed attribute: __doc__ */
+const char SeqEvent_is_fixed__doc__ [] =
+  "is_fixed -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is fixed (True) or not (False).\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_fixed attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_fixed(SeqEventObject *self) {
+  if (snd_seq_ev_is_fixed(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_variable attribute: __doc__ */
+const char SeqEvent_is_variable__doc__ [] =
+  "is_variable -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is variable (True) or not (False).\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_variable attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_variable(SeqEventObject *self) {
+  if (snd_seq_ev_is_variable(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_varusr attribute: __doc__ */
+const char SeqEvent_is_varusr__doc__ [] =
+  "is_varusr -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is varusr (True) or not (False).\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_varusr attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_varusr(SeqEventObject *self) {
+  if (snd_seq_ev_is_varusr(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_tick attribute: __doc__ */
+const char SeqEvent_is_tick__doc__ [] =
+  "is_tick -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is tick timed (True) or not (False).\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_tick attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_tick(SeqEventObject *self) {
+  if (snd_seq_ev_is_tick(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_real attribute: __doc__ */
+const char SeqEvent_is_real__doc__ [] =
+  "is_real -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is real timed (True) or not (False).\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_real attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_real(SeqEventObject *self) {
+  if (snd_seq_ev_is_real(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_abstime attribute: __doc__ */
+const char SeqEvent_is_abstime__doc__ [] =
+  "is_abstime -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is abstime timed (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_abstime attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_abstime(SeqEventObject *self) {
+  if (snd_seq_ev_is_abstime(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_reltime attribute: __doc__ */
+const char SeqEvent_is_reltime__doc__ [] =
+  "is_reltime -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is a reltime timed (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_reltime attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_reltime(SeqEventObject *self) {
+  if (snd_seq_ev_is_reltime(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent is_direct attribute: __doc__ */
+const char SeqEvent_is_direct__doc__ [] =
+  "is_direct -> boolean\n"
+  "\n"
+  "Indicates if this alsaseq.SeqEvent is sent directly (True) or not\n"
+  "(False). Note: read-only attribute."
+  ;
+
+/** alsaseq.SeqEvent is_direct attribute: tp_getset getter() */
+static PyObject *
+SeqEvent_is_direct(SeqEventObject *self) {
+  if (snd_seq_ev_is_direct(self->event)) {
+    Py_RETURN_TRUE;
+  } else {
+    Py_RETURN_FALSE;
+  }
+}
+
+/** alsaseq.SeqEvent _dtype attribute: __doc__ */
+const char SeqEvent__dtype__doc__ [] =
+  "_dtype -> dictionary\n"
+  "\n"
+  "Dictionary will available event type constants."
+  ;
+
+/** alsaseq.Seqevent _dtype attribute: tp_getset getter() */
+static PyObject *
+SeqEvent__dtype(SeqEventObject *self) {
+  Py_INCREF(_dictPYALSASEQ_CONST_EVENT_TYPE);
+  return _dictPYALSASEQ_CONST_EVENT_TYPE;
+}
+
+/** alsaseq.SeqEvent _dtimestamp attribute: __doc__ */
+const char SeqEvent__dtimestamp__doc__ [] =
+  "_dtimestamp -> dictionary\n"
+  "\n"
+  "Dictionary will available event timestamp constants."
+  ;
+
+/** alsaseq.Seqevent _dtimestamp attribute: tp_getset getter() */
+static PyObject *
+SeqEvent__dtimestamp(SeqEventObject *self) {
+  Py_INCREF(_dictPYALSASEQ_CONST_EVENT_TIMESTAMP);
+  return _dictPYALSASEQ_CONST_EVENT_TIMESTAMP;
+}
+
+/** alsaseq.SeqEvent _dtimemode attribute: __doc__ */
+const char SeqEvent__dtimemode__doc__ [] =
+  "_dtimemode -> dictionary\n"
+  "\n"
+  "Dictionary of available event timemode constants."
+  ;
+
+/** alsaseq.Seqevent _dtimemode attribute: tp_getset getter() */
+static PyObject *
+SeqEvent__dtimemode(SeqEventObject *self) {
+  Py_INCREF(_dictPYALSASEQ_CONST_EVENT_TIMEMODE);
+  return _dictPYALSASEQ_CONST_EVENT_TIMEMODE;
+}
+
+/** alsaseq.SeqEvent _dqueue attribute: __doc__ */
+const char SeqEvent__dqueue__doc__ [] =
+  "_dqueue -> dictionary\n"
+  "\n"
+  "Dictionary of known queue id constants."
+  ;
+
+/** alsaseq.Seqevent _dqueue attribute: tp_getset getter() */
+static PyObject *
+SeqEvent__dqueue(SeqEventObject *self) {
+  Py_INCREF(_dictPYALSASEQ_CONST_QUEUE);
+  return _dictPYALSASEQ_CONST_QUEUE;
+}
+
+/** alsaseq.SeqEvent _dclient attribute: __doc__ */
+const char SeqEvent__dclient__doc__ [] =
+  "_dclient -> dictionary\n"
+  "\n"
+  "Dictionary of known client addresses constants."
+  ;
+
+/** alsaseq.Seqevent _dclient attribute: tp_getset getter() */
+static PyObject *
+SeqEvent__dclient(SeqEventObject *self) {
+  Py_INCREF(TDICT(ADDR_CLIENT));
+  return TDICT(ADDR_CLIENT);
+}
+
+/** alsaseq.SeqEvent _dport attribute: __doc__ */
+const char SeqEvent__dport__doc__ [] =
+  "_dport -> dictionary\n"
+  "\n"
+  "Dictionary of known port addresses constants."
+  ;
+
+/** alsaseq.Seqevent _dport attribute: tp_getset getter() */
+static PyObject *
+SeqEvent__dport(SeqEventObject *self) {
+  Py_INCREF(TDICT(ADDR_PORT));
+  return TDICT(ADDR_PORT);
+}
+
+
+/** alsaseq.SeqEvent tp_getset list */
+static PyGetSetDef SeqEvent_getset[] = {
+  {"type",
+   (getter) SeqEvent_get_type,
+   (setter) SeqEvent_set_type,
+   (char *) SeqEvent_type__doc__,
+   NULL},
+  {"timestamp",
+   (getter) SeqEvent_get_timestamp,
+   (setter) SeqEvent_set_timestamp,
+   (char *) SeqEvent_timestamp__doc__,
+   NULL},
+  {"timemode",
+   (getter) SeqEvent_get_timemode,
+   (setter) SeqEvent_set_timemode,
+   (char *) SeqEvent_timemode__doc__,
+   NULL},
+  {"tag",
+   (getter) SeqEvent_get_tag,
+   (setter) SeqEvent_set_tag,
+   (char *) SeqEvent_tag__doc__,
+   NULL},
+  {"queue",
+   (getter) SeqEvent_get_queue,
+   (setter) SeqEvent_set_queue,
+   (char *) SeqEvent_queue__doc__,
+   NULL},
+  {"time",
+   (getter) SeqEvent_get_time,
+   (setter) SeqEvent_set_time,
+   (char *) SeqEvent_time__doc__,
+   NULL},
+  {"source",
+   (getter) SeqEvent_get_source,
+   (setter) SeqEvent_set_source,
+   (char *) SeqEvent_source__doc__,
+   NULL},
+  {"dest",
+   (getter) SeqEvent_get_dest,
+   (setter) SeqEvent_set_dest,
+   (char *) SeqEvent_dest__doc__,
+   NULL},
+  {"is_result_type",
+   (getter) SeqEvent_is_result_type,
+   NULL,
+   (char *) SeqEvent_is_result_type__doc__,
+   NULL},
+  {"is_note_type",
+   (getter) SeqEvent_is_note_type,
+   NULL,
+   (char *) SeqEvent_is_note_type__doc__,
+   NULL},
+  {"is_control_type",
+   (getter) SeqEvent_is_control_type,
+   NULL,
+   (char *) SeqEvent_is_control_type__doc__,
+   NULL},
+  {"is_channel_type",
+   (getter) SeqEvent_is_channel_type,
+   NULL,
+   (char *) SeqEvent_is_channel_type__doc__,
+   NULL},
+  {"is_queue_type",
+   (getter) SeqEvent_is_queue_type,
+   NULL,
+   (char *) SeqEvent_is_queue_type__doc__,
+   NULL},
+  {"is_message_type",
+   (getter) SeqEvent_is_message_type,
+   NULL,
+   (char *) SeqEvent_is_message_type__doc__,
+   NULL},
+  {"is_subscribe_type",
+   (getter) SeqEvent_is_subscribe_type,
+   NULL,
+   (char *) SeqEvent_is_subscribe_type__doc__,
+   NULL},
+  {"is_sample_type",
+   (getter) SeqEvent_is_sample_type,
+   NULL,
+   (char *) SeqEvent_is_sample_type__doc__,
+   NULL},
+  {"is_user_type",
+   (getter) SeqEvent_is_user_type,
+   NULL,
+   (char *) SeqEvent_is_user_type__doc__,
+   NULL},
+  {"is_instr_type",
+   (getter) SeqEvent_is_instr_type,
+   NULL,
+   (char *) SeqEvent_is_instr_type__doc__,
+   NULL},
+  {"is_fixed_type",
+   (getter) SeqEvent_is_fixed_type,
+   NULL,
+   (char *) SeqEvent_is_fixed_type__doc__,
+   NULL},
+  {"is_variable_type",
+   (getter) SeqEvent_is_variable_type,
+   NULL,
+   (char *) SeqEvent_is_variable_type__doc__,
+   NULL},
+  {"is_varusr_type",
+   (getter) SeqEvent_is_varusr_type,
+   NULL,
+   (char *) SeqEvent_is_varusr_type__doc__,
+   NULL},
+  {"is_reserved",
+   (getter) SeqEvent_is_reserved,
+   NULL,
+   (char *) SeqEvent_is_reserved__doc__,
+   NULL},
+  {"is_prior",
+   (getter) SeqEvent_is_prior,
+   NULL,
+   (char *) SeqEvent_is_prior__doc__,
+   NULL},
+  {"is_fixed",
+   (getter) SeqEvent_is_fixed,
+   NULL,
+   (char *) SeqEvent_is_fixed__doc__,
+   NULL},
+  {"is_variable",
+   (getter) SeqEvent_is_variable,
+   NULL,
+   (char *) SeqEvent_is_variable__doc__,
+   NULL},
+  {"is_varusr",
+   (getter) SeqEvent_is_varusr,
+   NULL,
+   (char *) SeqEvent_is_varusr__doc__,
+   NULL},
+  {"is_tick",
+   (getter) SeqEvent_is_tick,
+   NULL,
+   (char *) SeqEvent_is_tick__doc__,
+   NULL},
+  {"is_real",
+   (getter) SeqEvent_is_real,
+   NULL,
+   (char *) SeqEvent_is_real__doc__,
+   NULL},
+  {"is_abstime",
+   (getter) SeqEvent_is_abstime,
+   NULL,
+   (char *) SeqEvent_is_abstime__doc__,
+   NULL},
+  {"is_reltime",
+   (getter) SeqEvent_is_reltime,
+   NULL,
+   (char *) SeqEvent_is_reltime__doc__,
+   NULL},
+  {"is_direct",
+   (getter) SeqEvent_is_direct,
+   NULL,
+   (char *) SeqEvent_is_direct__doc__,
+   NULL},
+  {"_dtype",
+   (getter) SeqEvent__dtype,
+   NULL,
+   (char *) SeqEvent__dtype__doc__,
+   NULL},
+  {"_dtimestamp",
+   (getter) SeqEvent__dtimestamp,
+   NULL,
+   (char *) SeqEvent__dtimestamp__doc__,
+   NULL},
+  {"_dtimemode",
+   (getter) SeqEvent__dtimemode,
+   NULL,
+   (char *) SeqEvent__dtimemode__doc__,
+   NULL},
+  {"_dqueue",
+   (getter) SeqEvent__dqueue,
+   NULL,
+   (char *) SeqEvent__dqueue__doc__,
+   NULL},
+  {"_dclient",
+   (getter) SeqEvent__dclient,
+   NULL,
+   (char *) SeqEvent__dclient__doc__,
+   NULL},
+  {"_dport",
+   (getter) SeqEvent__dport,
+   NULL,
+   (char *) SeqEvent__dport__doc__,
+   NULL},
+  {NULL}
+};
+
+/** alsaseq.SeqEvent tp_repr */
+static PyObject *
+SeqEvent_repr(SeqEventObject *self) {
+  PyObject *key = PyInt_FromLong(self->event->type);
+  ConstantObject *constObject = (ConstantObject *)
+    PyDict_GetItem(TDICT(EVENT_TYPE), key);
+  const char *typestr = "UNKNOWN";
+  const char *timemode = "";
+  unsigned int dtime = 0;
+  unsigned int ntime = 0;
+  Py_DECREF(key);
+  if (constObject != NULL) {
+    typestr = constObject->name;
+  }
+
+  if (snd_seq_ev_is_real(self->event)) {
+    timemode = "real";
+    dtime = self->event->time.time.tv_sec;
+    ntime += self->event->time.time.tv_nsec * 0.000001;
+  } else {
+    timemode = "tick";
+    dtime = self->event->time.tick;
+  }
+
+  return PyString_FromFormat("<alsaseq.SeqEvent type=%s(%d) flags=%d tag=%d "
+			     "queue=%d time=%s(%u.%u) from=%d:%d to=%d:%d "
+			     "at 0x%p>",
+			     typestr,
+			     self->event->type, self->event->flags,
+			     self->event->tag, self->event->queue,
+			     timemode, dtime, ntime,
+			     (self->event->source).client,
+			     (self->event->source).port,
+			     (self->event->dest).client,
+			     (self->event->dest).port, self);
+}
+
+/** alsaseq.SeqEvent get_data() method: __doc__ */
+const char SeqEvent_get_data__doc__ [] =
+  "get_data() -> dict\n"
+  "\n"
+  "Returns a new dictionary with the data of this SeqEvent.\n"
+  "Changes to the returned dictionary will not change this SeqEvent data,\n"
+  "for changing an event data use the set_data() method.\n"
+  "\n"
+  "The dictionary items are key: value; where key is the name of the\n"
+  "data structure from alsa API and value is an integer or a list of them.\n"
+  "\n"
+  "The following name of structures are available:\n"
+  "  'note.channel' -> int\n"
+  "  'note.note' -> int\n"
+  "  'note.velocity' -> int\n"
+  "  'note.off_velocity' -> int\n"
+  "  'note.duration' -> int\n"
+  "  'control.channel' -> int\n"
+  "  'control.value' -> int\n"
+  "  'control.param' -> int\n"
+  "  'queue.queue' -> int\n"
+  "  'addr.client' -> int\n"
+  "  'addr.port' -> int\n"
+  "  'connect.sender.client' -> int\n"
+  "  'connect.sender.port' -> int\n"
+  "  'connect.dest.client' -> int\n"
+  "  'connect.dest.port' -> int\n"
+  "  'result.event' -> int\n"
+  "  'result.result' -> int\n"
+  "  'ext' -> list of int with sysex or variable data\n"
+  "\n"
+  "The exact items returned dependens on the event type of this SeqEvent.\n"
+  "For a control event, only 'control.*' may be returned; for a sysex \n"
+  "event, only 'ext' may be returned; for a note event, only 'note.*' may \n"
+  "be returned and so on."
+  ;
+
+/** alsaseq.SeqEvent get_data() method */
+static PyObject *
+SeqEvent_get_data(SeqEventObject *self,
+		  PyObject *args) {
+  PyObject *dict = PyDict_New();
+  snd_seq_event_t *event = self->event;
+
+  switch (event->type) {
+  case SND_SEQ_EVENT_SYSTEM:
+  case SND_SEQ_EVENT_RESULT:
+    SETDICT_RESU2;
+    break;
+
+  case SND_SEQ_EVENT_NOTE:
+    SETDICT_NOTE5;
+    break;
+
+  case SND_SEQ_EVENT_NOTEON:
+  case SND_SEQ_EVENT_NOTEOFF:
+  case SND_SEQ_EVENT_KEYPRESS:
+    SETDICT_NOTE3;
+    break;
+
+  case SND_SEQ_EVENT_CONTROLLER:
+    SETDICT_CTRL3;
+    break;
+
+  case SND_SEQ_EVENT_PGMCHANGE:
+  case SND_SEQ_EVENT_CHANPRESS:
+  case SND_SEQ_EVENT_PITCHBEND:
+    SETDICT_CTRL2;
+    break;
+
+  case SND_SEQ_EVENT_CONTROL14:
+  case SND_SEQ_EVENT_NONREGPARAM:
+  case SND_SEQ_EVENT_REGPARAM:
+    SETDICT_CTRL3;
+    break;
+
+  case SND_SEQ_EVENT_SONGPOS:
+  case SND_SEQ_EVENT_SONGSEL:
+  case SND_SEQ_EVENT_QFRAME:
+  case SND_SEQ_EVENT_TIMESIGN:
+  case SND_SEQ_EVENT_KEYSIGN:
+    SETDICT_CTRL1;
+    break;
+
+  case SND_SEQ_EVENT_START:
+  case SND_SEQ_EVENT_CONTINUE:
+  case SND_SEQ_EVENT_STOP:
+  case SND_SEQ_EVENT_SETPOS_TICK:
+  case SND_SEQ_EVENT_TEMPO:
+    SETDICT_QUEU1;
+    break;
+
+  case SND_SEQ_EVENT_CLOCK:
+  case SND_SEQ_EVENT_TICK:
+    break;
+
+  case SND_SEQ_EVENT_QUEUE_SKEW:
+    SETDICT_QUEU1;
+    break;
+
+  case SND_SEQ_EVENT_TUNE_REQUEST:
+  case SND_SEQ_EVENT_RESET:
+  case SND_SEQ_EVENT_SENSING:
+    break;
+
+  case SND_SEQ_EVENT_CLIENT_START:
+  case SND_SEQ_EVENT_CLIENT_EXIT:
+  case SND_SEQ_EVENT_CLIENT_CHANGE:
+    SETDICT_ADDR1;
+    break;
+
+  case SND_SEQ_EVENT_PORT_START:
+  case SND_SEQ_EVENT_PORT_EXIT:
+  case SND_SEQ_EVENT_PORT_CHANGE:
+    SETDICT_ADDR2;
+    break;
+
+  case SND_SEQ_EVENT_PORT_SUBSCRIBED:
+  case SND_SEQ_EVENT_PORT_UNSUBSCRIBED:
+    SETDICT_CONN4;
+    break;
+
+  case SND_SEQ_EVENT_SYSEX:
+    SETDICT_EXT;
+    break;
+  }
+
+  return dict;
+}
+
+/** alsaseq.SeqEvent set_data() method: __doc__ */
+const char SeqEvent_set_data__doc__ [] =
+  "set_data(dict)"
+  "\n"
+  "Changes the data of this SeqEvent, updating internal data structure \n"
+  "from the given dictionary.\n"
+  "\n"
+  "The dictionary items should be the same as described in the get_data() \n"
+  "method and be the appropiate for this SeqEvent type.\n"
+  "\n"
+  "This method does not check if a given structure correspond to is valid \n"
+  "for this SeqEvent type; so setting the 'control.param' or the 'ext' \n"
+  "structures for a NOTE SeqEvent may change another data structure \n"
+  "or will simple have no effect once sent."
+  ;
+
+/** alsaseq.SeqEvent set_data() method */
+static PyObject *
+SeqEvent_set_data(SeqEventObject *self,
+				   PyObject *args) {
+  PyObject *dict = NULL;
+  snd_seq_event_t *event = self->event;
+
+  if (!PyArg_ParseTuple(args, "O",
+			&dict)) {
+    return NULL;
+  }
+
+  if (!PyDict_Check(dict)) {
+    PyErr_SetString(PyExc_TypeError, "must be a dictionary");
+    return NULL;
+  }
+
+  GETDICTINT("note.channel", event->data.note.channel);
+  GETDICTINT("note.note", event->data.note.note);
+  GETDICTINT("note.velocity", event->data.note.velocity);
+  GETDICTINT("note.off_velocity", event->data.note.off_velocity);
+  GETDICTINT("note.duration", event->data.note.duration);
+
+  GETDICTINT("control.channel", event->data.control.channel);
+  GETDICTINT("control.param", event->data.control.param);
+  GETDICTINT("control.value", event->data.control.value);
+
+  GETDICTEXT("ext");
+
+  GETDICTINT("queue.queue", event->data.queue.queue);
+  GETDICTINT("queue.param.value", event->data.queue.param.value);
+
+  GETDICTINT("addr.client", event->data.addr.client);
+  GETDICTINT("addr.port", event->data.addr.port);
+
+  GETDICTINT("connect.sender.client", event->data.connect.sender.client);
+  GETDICTINT("connect.sender.port", event->data.connect.sender.port);
+  GETDICTINT("connect.dest.client", event->data.connect.dest.client);
+  GETDICTINT("connect.dest.port", event->data.connect.dest.port);
+
+  GETDICTINT("result.event", event->data.result.event);
+  GETDICTINT("result.result", event->data.result.result);
+
+  Py_RETURN_NONE;
+}
+
+
+/** alsaseq.SeqEvent tp_methods */
+static PyMethodDef SeqEvent_methods[] = {
+  {"get_data",
+   (PyCFunction) SeqEvent_get_data,
+   METH_VARARGS,
+   SeqEvent_get_data__doc__},
+  {"set_data",
+   (PyCFunction) SeqEvent_set_data,
+   METH_VARARGS,
+   SeqEvent_set_data__doc__},
+  {NULL}
+};
+
+/** alsaseq.SeEvent type */
+static PyTypeObject SeqEventType = {
+  PyObject_HEAD_INIT(NULL)
+  tp_name: "alsaseq.SeqEvent",
+  tp_basicsize: sizeof(SeqEventObject),
+  tp_dealloc: (destructor) SeqEvent_dealloc,
+  tp_flags: Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE,
+  tp_doc: SeqEvent__doc__,
+  tp_init: (initproc)SeqEvent_init,
+  tp_new : SeqEvent_new,
+  tp_alloc: PyType_GenericAlloc,
+  tp_free: PyObject_Del,
+  tp_methods: SeqEvent_methods,
+  tp_getset: SeqEvent_getset,
+  tp_repr: (reprfunc)SeqEvent_repr,
+};
+
+
+
+//////////////////////////////////////////////////////////////////////////////
+// alsaseq.Sequencer implementation
+//////////////////////////////////////////////////////////////////////////////
+
+/** alsaseq.Sequencer __doc__ */
+const char Sequencer__doc__[] =
+  "Sequencer([name, clientname, streams, mode, maxreceiveevents]) "
+  "-> Sequencer object\n"
+  "\n"
+  "Creates and opens an ALSA sequencer. The features of the Sequencer are:\n"
+  "- send/receive events (as SeqEvent objects)\n"
+  "- create ports\n"
+  "- list all ALSA clients and their port connections\n"
+  "- connect/disconnect arbitrary ports\n"
+  "- create and control queues\n"
+  "- get info about a port or a client\n"
+  "\n"
+  "The name must correspond to the special ALSA name (for example: 'hw'); \n"
+  "if not specified, 'default' is used. The clientname is the name of this \n"
+  "client; if not specified, 'pyalsa-PID' is used.\n"
+  "\n"
+  "The streams specifies if you want to receive, send or both; use \n"
+  "SEQ_OPEN_INPUT, SEQ_OPEN_OUTPUT or SEQ_OPEN_DUPLEX. If not specified, \n"
+  "SEQ_OPEN_DUPLEX is used."
+  "\n"
+  "The mode specifies if this client should block or not, use SEQ_BLOCK or \n"
+  "SEQ_NONBLOCK. If not specified, SEQ_NONBLOCK is used."
+  "\n"
+  "The maxreceiveevents is a number that represents how many SeqEvent \n"
+  "objects are returned by the receive() method. If not specified, the \n"
+  "default is 4. \n"
+  "\n"
+  "There is no method for closing the sequencer, it will remain open as \n"
+  "long as the Sequencer object exists. For closing the sequencer you \n"
+  "must explicitly del() the returned object."
+  ;
+
+/** alsaseq.Sequencer object structure type */
+typedef struct {
+  PyObject_HEAD
+
+  /* streams */
+  int streams;
+  /* mode */
+  int mode;
+
+  /* alsa handler */
+  snd_seq_t *handle;
+  /* max fd's */
+  int receive_max;
+  /* receive poll fd's */
+  struct pollfd *receive_fds;
+  /* max events for returning in receive_events() */
+  int receive_max_events;
+  /* remaining bytes from input */
+  int receive_bytes;
+} SequencerObject;
+
+/** alsaseq.Sequencer type (initialized later...) */
+static PyTypeObject SequencerType;
+
+/** alsaseq.Sequencer: tp_init */
+static int
+Sequencer_init(SequencerObject *self,
+			  PyObject *args, PyObject *kwds) {
+  int ret;
+  /* defaults */
+  char *name = "default";
+  char *clientname = NULL;
+  char tmpclientname[1024];
+
+  self->streams = SND_SEQ_OPEN_DUPLEX;
+  self->mode = SND_SEQ_NONBLOCK;
+  int maxreceiveevents = 4;
+
+  char *kwlist[] = { "name", "clientname", "streams", "mode",
+		     "maxreceiveevents", NULL };
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "|ssiii", kwlist, &name,
+				   &clientname, &self->streams,
+				   &self->mode, &maxreceiveevents)) {
+    return -1;
+  }
+
+  if (clientname == NULL) {
+    tmpclientname[0] = 0;
+    sprintf(tmpclientname, "pyalsa-%d", getpid());
+    clientname = tmpclientname;
+  }
+
+  self->receive_fds = NULL;
+  self->receive_max = 0;
+  self->receive_bytes = 0;
+  self->receive_max_events = maxreceiveevents;
+
+
+  ret = snd_seq_open(&(self->handle), name, self->streams,
+		     self->mode);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to create sequencer");
+    return -1;
+  }
+  ret = snd_seq_set_client_name(self->handle, clientname);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to set client name");
+    return -1;
+  }
+
+  return 0;
+}
+
+/** alsaseq.Sequencer: tp_dealloc */
+static void
+Sequencer_dealloc(SequencerObject *self) {
+  FREECHECKED("receive_fds", self->receive_fds);
+
+  if (self->handle) {
+    snd_seq_close(self->handle);
+    self->handle = NULL;
+  }
+
+  self->ob_type->tp_free(self);
+}
+
+/** alsaseq.Sequencer name attribute: __doc__ */
+const char Sequencer_name__doc__ [] =
+  "name -> string\n"
+  "\n"
+  "The alsa device name of this alsaseq.Sequencer.\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.Sequencer name attribute: tp_getset getter() */
+static PyObject *
+Sequencer_get_name(SequencerObject *self) {
+  return PyString_FromString(snd_seq_name(self->handle));
+}
+
+/** alsaseq.Sequencer clientname attribute: __doc__ */
+const char Sequencer_clientname__doc__ [] =
+  "clientname -> string\n"
+  "\n"
+  "The client name of this alsaseq.Sequencer\n"
+  ;
+
+/** alsaseq.Sequencer clientname attribute: tp_getset getter() */
+static PyObject *
+Sequencer_get_clientname(SequencerObject *self) {
+  snd_seq_client_info_t *cinfo;
+
+  snd_seq_client_info_alloca(&cinfo);
+  snd_seq_get_client_info(self->handle, cinfo);
+
+  return PyString_FromString(snd_seq_client_info_get_name(cinfo));
+}
+
+/** alsaseq.Sequencer clientname attribute: tp_getset setter() */
+static int
+Sequencer_set_clientname(SequencerObject *self,
+			 PyObject *val) {
+  char *buff;
+
+  SETCHECKPYSTR("clientname", val);
+
+  buff = PyString_AsString(val);
+
+  snd_seq_set_client_name(self->handle, PyString_AsString(val));
+
+  return 0;
+}
+
+/** alsaseq.Sequencer streams attribute: __doc__ */
+const char Sequencer_streams__doc__ [] =
+  "streams -> Constant object\n"
+  "\n"
+  "The streams of this alsaseq.Sequencer. Posible values:\n"
+  "alsaseq.SEQ_OPEN_OUTPUT, alsaseq.SEQ_OPEN_INPUT, \n"
+  "alsaseq.SEQ_OPEN_DUPLEX.\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.Sequencer streams attribute: tp_getset getter() */
+static PyObject *
+Sequencer_get_streams(SequencerObject *self) {
+  TCONSTRETURN(STREAMS, self->streams);
+}
+
+/** alsaseq.Sequencer mode attribute: __doc__ */
+const char Sequencer_mode__doc__ [] =
+  "mode -> Constant object\n"
+  "\n"
+  "The blocking mode of this alsaseq.Sequencer. Use\n"
+  "alsaseq.SEQ_BLOCK, alsaseq.SEQ_NONBLOCK."
+  ;
+
+/** alsaseq.Sequencer mode attribute: tp_getset getter() */
+static PyObject *Sequencer_get_mode(SequencerObject *self) {
+  TCONSTRETURN(MODE, self->mode);
+}
+
+/** alsaseq.Sequencer mode attribute: tp_getset setter() */
+static int
+Sequencer_set_mode(SequencerObject *self,
+		   PyObject *val) {
+  int ret, mode;
+
+  SETCHECKPYINT("mode", val);
+
+  mode = (int) PyInt_AsLong(val);
+
+  if (mode != 0 && mode != SND_SEQ_NONBLOCK) {
+    PyErr_SetString(PyExc_ValueError, "Invalid value for mode.");
+    return -1;
+  }
+
+  ret = snd_seq_nonblock(self->handle, mode);
+  if (ret == 0) {
+    self->mode = mode;
+  } else {
+    RAISESND(ret, "Failed to set mode");
+    return -1;
+  }
+  return 0;
+}
+
+/** alsaseq.Sequencer client_id attribute: __doc__ */
+const char Sequencer_client_id__doc__ [] =
+  "client_id -> int\n"
+  "\n"
+  "The client id of this alsaseq.Sequencer.\n"
+  "Note: read-only attribute."
+  ;
+
+/** alsaseq.Sequencer client_id attribute: tp_getset getter() */
+static PyObject *
+Sequencer_get_client_id(SequencerObject *self) {
+  snd_seq_client_info_t *cinfo;
+
+  snd_seq_client_info_alloca(&cinfo);
+  snd_seq_get_client_info(self->handle, cinfo);
+  return PyInt_FromLong(snd_seq_client_info_get_client(cinfo));
+}
+
+/** alsaseq.Sequencer: tp_getset list*/
+static PyGetSetDef Sequencer_getset[] = {
+  {"name",
+   (getter) Sequencer_get_name,
+   NULL,
+   (char *) Sequencer_name__doc__,
+   NULL},
+  {"clientname",
+   (getter) Sequencer_get_clientname,
+   (setter) Sequencer_set_clientname,
+   (char *) Sequencer_clientname__doc__,
+   NULL},
+  {"streams",
+   (getter) Sequencer_get_streams,
+   NULL,
+   (char *) Sequencer_streams__doc__,
+   NULL},
+  {"mode",
+   (getter) Sequencer_get_mode,
+   (setter) Sequencer_set_mode,
+   (char *) Sequencer_mode__doc__,
+   NULL},
+  {"client_id",
+   (getter) Sequencer_get_client_id,
+   NULL,
+   (char *) Sequencer_client_id__doc__,
+   NULL},
+  {NULL}
+};
+
+/** alsaseq.Sequencer: tp_repr */
+static PyObject *
+Sequencer_repr(SequencerObject *self) {
+  snd_seq_client_info_t *cinfo;
+
+  snd_seq_client_info_alloca(&cinfo);
+  snd_seq_get_client_info(self->handle, cinfo);
+
+  return PyString_FromFormat("<alsaseq.Sequencer name=%s client_id=%d "
+			     "clientname=%s streams=%d mode=%d at 0x%p>",
+			     snd_seq_name(self->handle),
+			     snd_seq_client_info_get_client(cinfo),
+			     snd_seq_client_info_get_name(cinfo),
+			     self->streams,
+			     self->mode,
+			     self
+			     );
+}
+
+/** alsaseq.Sequencer create_simple_port() method: __doc__ */
+const char Sequencer_create_simple_port__doc__ [] =
+  "create_simple_port(name, type, caps=0) -> int"
+  "\n"
+  "Creates a port for receiving or sending events.\n"
+  "\n"
+  "Parameters:\n"
+  "    name -- name of the port\n"
+  "    type -- type of port (use one of the alsaseq.SEQ_PORT_TYPE_*\n"
+  "            constants)\n"
+  "    caps -- capabilites of the port (use bitwise alsaseq.SEQ_PORT_CAP_*\n"
+  "            constants). Default=0\n"
+  "Returns:\n"
+  "  the port id.\n"
+  "Raises:\n"
+  "  TypeError: if an invalid type was used in a parameter\n"
+  "  ValueError: if an invalid value was used in a parameter\n"
+  "  SequencerError: if ALSA can't create the port"
+  ;
+	
+
+/** alsaseq.Sequencer create_simple_port() method */
+static PyObject *
+Sequencer_create_simple_port(SequencerObject *self,
+			     PyObject *args,
+			     PyObject *kwds) {
+  char *name;
+  unsigned int type;
+  unsigned int caps=0;
+  char *kwlist[] = { "name", "type", "caps", NULL };
+  int port;
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "sI|I", kwlist,
+				   &name, &type, &caps)) {
+    return NULL;
+  }
+
+  port = snd_seq_create_simple_port(self->handle, name, caps, type);
+  if (port < 0) {
+    RAISESND(port, "Failed to create simple port");
+    return NULL;
+  }
+
+  return PyInt_FromLong(port);
+}
+
+/** alsaseq.Sequencer connection_list() method: __doc__ */
+const char Sequencer_connection_list__doc__ [] =
+  "connection_list() -> list\n"
+  "\n"
+  "List all clients and their ports connections.\n"
+  "\n"
+  "Returns:\n"
+  "  (list) a list of tuples: client_name, client_id, port_list:.\n"
+  "    client_name -- the client's name.\n"
+  "    client_id -- the client's id.\n"
+  "    port_list -- a list of tuples: port_name, port_id, connection_list:\n"
+  "      port_name -- the name of the port.\n"
+  "      port_id -- the port id.\n"
+  "      connection_list -- a list of tuples: read_conn, write_conn:\n"
+  "        read_conn -- a list of (client_id, port_id, info) tuples this\n"
+  "                     port is connected to (sends events);\n"
+  "                     info is the same of the get_connect_info() method.\n"
+  "        write_conn -- a list of (client_id, port_id, info) tuples this\n"
+  "                      port is connected from (receives events);\n"
+  "                      info is the same of the get_connect_info() method.\n"
+  ;
+
+
+static PyObject *
+_query_connections_list(snd_seq_t *handle,
+			snd_seq_query_subscribe_t *query,
+			int type) {
+
+  PyObject *list = PyList_New(0);
+  int index = 0;
+  long tmplong;
+  snd_seq_query_subscribe_set_type(query, type);
+  snd_seq_query_subscribe_set_index(query, index);
+  while (snd_seq_query_port_subscribers(handle, query) >= 0) {
+    const snd_seq_addr_t *addr =
+      snd_seq_query_subscribe_get_addr(query);
+
+    PyObject *dict = PyDict_New();
+
+    tmplong = snd_seq_query_subscribe_get_queue(query);
+    PyDict_SetItemString(dict, "queue", PyInt_FromLong(tmplong));
+
+    tmplong = snd_seq_query_subscribe_get_exclusive(query);
+    PyDict_SetItemString(dict, "exclusive", PyInt_FromLong(tmplong));
+
+    tmplong = snd_seq_query_subscribe_get_time_update(query);
+    PyDict_SetItemString(dict, "time_update", PyInt_FromLong(tmplong));
+
+    tmplong = snd_seq_query_subscribe_get_time_real(query);
+    PyDict_SetItemString(dict, "time_real", PyInt_FromLong(tmplong));
+
+
+    PyObject *tuple = PyTuple_New(3);
+    PyTuple_SetItem(tuple, 0, PyInt_FromLong(addr->client));
+    PyTuple_SetItem(tuple, 1, PyInt_FromLong(addr->port));
+    PyTuple_SetItem(tuple, 2, dict);
+
+    PyList_Append(list, tuple);
+    snd_seq_query_subscribe_set_index(query, ++index);
+  }
+  return list;
+}
+
+static PyObject *
+_query_connections(snd_seq_t *handle,
+		   const snd_seq_addr_t *addr) {
+  snd_seq_query_subscribe_t *query;
+  snd_seq_query_subscribe_alloca(&query);
+  snd_seq_query_subscribe_set_root(query, addr);
+
+  // create tuple for read,write lists
+  PyObject *tuple = PyTuple_New(2);
+  PyObject *readlist = _query_connections_list(handle, query,
+					       SND_SEQ_QUERY_SUBS_READ);
+  PyObject *writelist = _query_connections_list(handle, query,
+						SND_SEQ_QUERY_SUBS_WRITE);
+  PyTuple_SetItem(tuple, 0, readlist);
+  PyTuple_SetItem(tuple, 1, writelist);
+
+  return tuple;
+}
+
+/** alsaseq.Sequencer connection_list() method */
+static PyObject *
+Sequencer_connection_list(SequencerObject *self,
+			  PyObject *args) {
+  snd_seq_client_info_t *cinfo;
+  snd_seq_port_info_t *pinfo;
+  PyObject *client, *port, *name;
+  PyObject *list = PyList_New(0);
+
+  if (list == NULL) {
+    return NULL;
+  }
+
+  snd_seq_client_info_alloca(&cinfo);
+  snd_seq_port_info_alloca(&pinfo);
+  snd_seq_client_info_set_client(cinfo, -1);
+  while (snd_seq_query_next_client(self->handle, cinfo) >= 0) {
+    /* reset query info */
+    snd_seq_port_info_set_client(pinfo,
+				 snd_seq_client_info_get_client(cinfo));
+    snd_seq_port_info_set_port(pinfo, -1);
+
+    /* create tuple for client info */
+    PyObject *tuple = PyTuple_New(3);
+    PyObject *portlist = PyList_New(0);
+
+    name = PyString_FromFormat("%s", snd_seq_client_info_get_name(cinfo));
+    client = PyInt_FromLong(snd_seq_client_info_get_client(cinfo));
+    PyTuple_SetItem(tuple, 0, name);
+    PyTuple_SetItem(tuple, 1, client);
+
+    while (snd_seq_query_next_port(self->handle, pinfo) >= 0) {
+      /* create tuple for port info */
+      PyObject *porttuple = PyTuple_New(3);
+
+      name = PyString_FromFormat("%s", snd_seq_port_info_get_name(pinfo));
+      port = PyInt_FromLong(snd_seq_port_info_get_port(pinfo));
+
+      PyTuple_SetItem(porttuple, 0, name);
+      PyTuple_SetItem(porttuple, 1, port);
+
+      /* create tuple for read,write connections */
+      PyObject *conntuple =
+	_query_connections(self->handle, snd_seq_port_info_get_addr(pinfo));
+      PyTuple_SetItem(porttuple, 2, conntuple);
+
+      PyList_Append(portlist, porttuple);
+    }
+    PyTuple_SetItem(tuple, 2, portlist);
+
+    /* append list of port tuples */
+    PyList_Append(list, tuple);
+  }
+
+  return list;
+}
+
+/** alsaseq.Sequencer get_client_info() method: __doc__ */
+const char Sequencer_get_client_info__doc__ [] =
+  "get_client_info(client_id = self.client_id) -> dictionary\n"
+  "\n"
+  "Retrieve info about an existing client.\n"
+  "\n"
+  "Parameters:\n"
+  "  client_id -- the client id (defaults to: self.client_id)\n"
+  "Returns:\n"
+  "  (dict) a dictionary with the following values:\n"
+  "    id  -- id of client.\n"
+  "    type -- type of client (SEQ_USER_CLIENT or SEQ_KERNEL_CLIENT).\n"
+  "    name -- name of client.\n"
+  "    broadcast_filter -- broadcast filter flag of client as int.\n"
+  "    error_bounce -- error bounce of client as int.\n"
+  "    event_filter -- event filter of client as string.\n"
+  "    num_ports -- number of opened ports of client.\n"
+  "    event_lost -- number of lost events of client.\n"
+  "Raises:\n"
+  " SequencerError: ALSA error occurred."
+  ;
+
+/** alsaseq.Sequencer get_client_info() method */
+static PyObject *
+Sequencer_get_client_info(SequencerObject *self,
+			  PyObject *args,
+			  PyObject *kwds) {
+  snd_seq_client_info_t *cinfo;
+  int client_id = -1;
+  int ret;
+  PyObject *tmpobj;
+  long tmplong;
+  const char * tmpchar;
+  char *kwlist[] = { "client_id", NULL};
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "|i", kwlist,
+				   &client_id)) {
+    return NULL;
+  }
+
+  snd_seq_client_info_alloca(&cinfo);
+  if (client_id == -1) {
+    ret = snd_seq_get_client_info(self->handle, cinfo);
+    if (ret < 0) {
+      RAISESND(ret, "Failed to retrieve client info for self.client_id");
+      return NULL;
+    }
+    client_id = snd_seq_client_info_get_client(cinfo);
+  } else {
+    ret = snd_seq_get_any_client_info(self->handle, client_id, cinfo);
+    if (ret < 0) {
+      RAISESND(ret, "Failed to retrieve client info for '%d'", client_id);
+      return NULL;
+    }
+  }
+
+  PyObject *dict = PyDict_New();
+  if (dict == NULL) {
+    return NULL;
+  }
+
+  TCONSTASSIGN(ADDR_CLIENT, client_id, tmpobj);
+  PyDict_SetItemString(dict, "id", tmpobj);
+
+  tmplong = snd_seq_client_info_get_type(cinfo);
+  TCONSTASSIGN(CLIENT_TYPE, tmplong, tmpobj);
+  PyDict_SetItemString(dict, "type", tmpobj);
+
+  tmpchar = snd_seq_client_info_get_name(cinfo);
+  tmpchar = (tmpchar == NULL ? "" : tmpchar);
+  PyDict_SetItemString(dict, "name", PyString_FromString(tmpchar));
+
+  tmplong = snd_seq_client_info_get_broadcast_filter(cinfo);
+  PyDict_SetItemString(dict, "broadcast_filter", PyInt_FromLong(tmplong));
+
+  tmplong = snd_seq_client_info_get_error_bounce(cinfo);
+  PyDict_SetItemString(dict, "error_bounce", PyInt_FromLong(tmplong));
+
+  tmpchar = (const char *)snd_seq_client_info_get_event_filter(cinfo);
+  tmpchar = (tmpchar == NULL ? "" : tmpchar);
+  PyDict_SetItemString(dict, "event_filter", PyString_FromString(tmpchar));
+
+  tmplong = snd_seq_client_info_get_num_ports(cinfo);
+  PyDict_SetItemString(dict, "num_ports", PyInt_FromLong(tmplong));
+
+  tmplong = snd_seq_client_info_get_event_lost(cinfo);
+  PyDict_SetItemString(dict, "event_lost", PyInt_FromLong(tmplong));
+
+  return dict;
+}
+
+/** alsaseq.Sequencer get_port_info() method: __doc__ */
+const char Sequencer_get_port_info__doc__ [] =
+  "get_port_info(port_id, client_id = self.client_id) -> dictionary\n"
+  "\n"
+  "Retrieve info about an existing client's port.\n"
+  "\n"
+  "Parameters:\n"
+  "  port_id -- the port id\n"
+  "  client_id -- the client id (defaults to: self.client_id)\n"
+  "Returns:\n"
+  "  (dict) a dictionary with the following values:\n"
+  "    name -- the port name\n"
+  "    type -- the port type bit flags\n"
+  "    capability -- the port capability bit flags as integer\n"
+  "Raises:\n"
+  "  SequencerError: ALSA error occurred."
+  ;
+
+/** alsaseq.Sequencer get_port_info() method */
+static PyObject *
+Sequencer_get_port_info(SequencerObject *self,
+			PyObject *args,
+			PyObject *kwds) {
+  snd_seq_port_info_t *pinfo;
+  snd_seq_client_info_t *cinfo;
+  int port_id;
+  int client_id;
+  const char *tmpchar;
+  long tmplong;
+  int ret;
+  char *kwlist[] = { "port_id", "client_id", NULL };
+
+  snd_seq_client_info_alloca(&cinfo);
+  ret = snd_seq_get_client_info(self->handle, cinfo);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to determine self.client_id");
+    return NULL;
+  }
+  client_id = snd_seq_client_info_get_client(cinfo);
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "i|i", kwlist,
+				   &port_id, &client_id)) {
+    return NULL;
+  }
+
+  PyObject *dict = PyDict_New();
+  if (dict == NULL) {
+    return NULL;
+  }
+
+  snd_seq_port_info_alloca(&pinfo);
+  ret = snd_seq_get_any_port_info(self->handle, client_id,
+				  port_id, pinfo);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to get port info for %d:%d", client_id, port_id);
+    return NULL;
+  }
+
+  tmpchar = snd_seq_port_info_get_name(pinfo);
+  tmpchar = (tmpchar == NULL ? "" : tmpchar);
+  PyDict_SetItemString(dict, "name", PyString_FromString(tmpchar));
+
+  tmplong = snd_seq_port_info_get_capability(pinfo);
+  PyDict_SetItemString(dict, "capability", PyInt_FromLong(tmplong));
+
+  tmplong = snd_seq_port_info_get_type(pinfo);
+  PyDict_SetItemString(dict, "type", PyInt_FromLong(tmplong));
+
+  return dict;
+}
+
+/** alsaseq.Sequencer connect_ports() method: __doc__ */
+const char Sequencer_connect_ports__doc__ [] =
+  "connect_ports(srcaddr,dstaddr,queue,exclusive,time_update,time_real)\n"
+  "\n"
+  "Connect the ports specified by srcaddr and dstaddr.\n"
+  "\n"
+  "Parameters:\n"
+  "  srcaddr -- (tuple) the (client_id, port_id) tuple for the source\n"
+  "              port (the port sending events)\n"
+  "  dstaddr -- (tuple) the (client_id, port_id) tuple for the destination\n"
+  "              port (the port receiveng events)\n"
+  "  queue   -- the queue of the connection.\n"
+  "             If not specified, defaults to 0.\n"
+  "  exclusive -- 1 if the connection is exclusive, 0 otherwise.\n"
+  "               If not specified, defaults to 0.\n"
+  "  time_update -- 1 if the connection should update time, 0 otherwise.\n"
+  "                 If not specified, defaults to 0.\n"
+  "  time_real -- 1 if the update time is in real, 0 if is in tick.\n"
+  "                 If not specified, defaults to 0.\n"
+  "Raises:\n"
+  "  SequenceError: if ALSA can't connect the ports"
+  ;
+
+/** alsaseq.Sequencer connect_ports() method */
+static PyObject *
+Sequencer_connect_ports(SequencerObject *self,
+			PyObject *args) {
+  snd_seq_addr_t sender, dest;
+  snd_seq_port_subscribe_t *sinfo;
+  int ret;
+  int queue = 0;
+  int exclusive = 0;
+  int time_update = 0;
+  int time_real = 0;
+
+  if (!PyArg_ParseTuple(args, "(BB)(BB)|iiii", &(sender.client),
+	                &(sender.port), &(dest.client), &(dest.port),
+			&queue, &exclusive, &time_update, &time_real)) {
+    return NULL;
+  }
+
+  snd_seq_port_subscribe_alloca(&sinfo);
+  snd_seq_port_subscribe_set_sender(sinfo, &sender);
+  snd_seq_port_subscribe_set_dest(sinfo, &dest);
+  snd_seq_port_subscribe_set_queue(sinfo, queue);
+  snd_seq_port_subscribe_set_exclusive(sinfo, exclusive);
+  snd_seq_port_subscribe_set_time_update(sinfo, time_update);
+  snd_seq_port_subscribe_set_time_real(sinfo, time_real);
+
+  ret = snd_seq_subscribe_port(self->handle, sinfo);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to connect ports %d:%d -> %d:%d",
+	     sender.client, sender.port, dest.client, dest.port);
+    return NULL;
+  }
+
+  Py_RETURN_NONE;
+}
+
+/** alsaseq.Sequencer disconnect_ports() method: __doc__ */
+const char Sequencer_disconnect_ports__doc__ [] =
+  "disconnect_ports(srcaddr, destaddr)\n"
+  "\n"
+  "Disconnect the ports specified by srcaddr and dstaddr.\n"
+  "\n"
+  "Parameters:\n"
+  "  srcaddr -- (tuple) the client_id, port_id tuple for the source\n"
+  "             port (the port sending events)\n"
+  "  dstaddr -- (tuple) the client_id, port_id tuple for the destination\n"
+  "             port (the port receiveng events)\n"
+  "Raises:\n"
+  "  SequenceError: if ALSA can't disconnect the port"
+  ;
+
+/** alsaseq.Sequencer disconnect_ports() method */
+static PyObject *
+Sequencer_disconnect_ports(SequencerObject *self,
+			   PyObject *args) {
+  snd_seq_addr_t sender, dest;
+  snd_seq_port_subscribe_t *sinfo;
+  int ret;
+
+  if (!PyArg_ParseTuple(args, "(BB)(BB)", &(sender.client),
+	                &(sender.port), &(dest.client), &(dest.port))) {
+    return NULL;
+  }
+
+  snd_seq_port_subscribe_alloca(&sinfo);
+  snd_seq_port_subscribe_set_sender(sinfo, &sender);
+  snd_seq_port_subscribe_set_dest(sinfo, &dest);
+
+  ret = snd_seq_unsubscribe_port(self->handle, sinfo);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to disconnect ports: %d:%d --> %d:%d",
+	     sender.client, sender.port, dest.client, dest.port);
+    return NULL;
+  }
+
+  Py_RETURN_NONE;
+}
+
+/** alsaseq.Sequencer get_connect_info() method: __doc__ */
+const char Sequencer_get_connect_info__doc__ [] =
+  "get_connect_info(srcaddr, dstaddr) -> dictionary\n"
+  "\n"
+  "Retrieve the subscribe info of the specified connection.\n"
+  "\n"
+  "Parameters:\n"
+  "  srcaddr -- (tuple) the client_id, port_id tuple for the source\n"
+  "             port (the port sending events)\n"
+  "  dstaddr -- (tuple) the client_id, port_id tuple for the destination\n"
+  "             port (the port receiveng events)\n"
+  "Returns:\n"
+  "  (dict) a dictionary with the following values:\n"
+  "    queue -- \n"
+  "    exclusive -- \n"
+  "    time_update -- \n"
+  "    time_real --- \n"
+  "Raises:\n"
+  "  SequenceError: if ALSA can't retrieve the connection or the\n"
+  "                 connection doesn't exists."
+  ;
+
+
+static PyObject*
+Sequencer_get_connect_info(SequencerObject *self,
+			  PyObject *args) {
+  snd_seq_addr_t sender, dest;
+  snd_seq_port_subscribe_t *sinfo;
+  int ret;
+  long tmplong;
+
+  if (!PyArg_ParseTuple(args, "(BB)(BB)", &(sender.client),
+	                &(sender.port), &(dest.client), &(dest.port))) {
+    return NULL;
+  }
+
+  snd_seq_port_subscribe_alloca(&sinfo);
+  snd_seq_port_subscribe_set_sender(sinfo, &sender);
+  snd_seq_port_subscribe_set_dest(sinfo, &dest);
+
+  ret = snd_seq_get_port_subscription(self->handle, sinfo);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to get port subscript: %d:%d --> %d:%d",
+	     sender.client, sender.port, dest.client, dest.port);
+    return NULL;
+  }
+
+  PyObject *dict = PyDict_New();
+
+  tmplong = snd_seq_port_subscribe_get_queue(sinfo);
+  PyDict_SetItemString(dict, "queue", PyInt_FromLong(tmplong));
+
+  tmplong = snd_seq_port_subscribe_get_exclusive(sinfo);
+  PyDict_SetItemString(dict, "exclusive", PyInt_FromLong(tmplong));
+
+  tmplong = snd_seq_port_subscribe_get_time_update(sinfo);
+  PyDict_SetItemString(dict, "time_update", PyInt_FromLong(tmplong));
+
+  tmplong = snd_seq_port_subscribe_get_time_real(sinfo);
+  PyDict_SetItemString(dict, "time_real", PyInt_FromLong(tmplong));
+
+  return dict;
+}
+
+/** alsaseq.Sequencer receive_events() method: __doc__ */
+const char Sequencer_receive_events__doc__ [] =
+  "receive_events(timeout = 0, maxevents = self.receive_maxevents) -> list\n"
+  "\n"
+  "Receive events.\n"
+  "\n"
+  "Parameters:\n"
+  "  timeout -- (int) time for wating for events in miliseconds\n"
+  "  maxevents -- (int) max events to be returned\n"
+  "Returns:\n"
+  "  (list) a list of alsaseq.SeqEvent objects\n"
+  "Raises:\n"
+  "  TypeError: if an invalid type was used in a parameter\n"
+  "  SequencerError: if ALSA error occurs."
+  ;
+
+/** alsaseq.Sequencer receive_events() method */
+static PyObject *
+Sequencer_receive_events(SequencerObject *self,
+			 PyObject *args,
+			 PyObject *kwds) {
+  int maxevents = self->receive_max_events;
+  snd_seq_event_t *event = NULL;
+  int timeout = 0;
+  int ret;
+
+  char *kwlist[] = {"timeout", "maxevents", NULL};
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "|ii", kwlist, &timeout,
+				   &maxevents)) {
+    return NULL;
+  }
+
+  if (self->receive_fds == NULL) {
+    self->receive_max = snd_seq_poll_descriptors_count(self->handle, POLLOUT);
+    self->receive_fds = malloc(sizeof(struct pollfd) * self->receive_max);
+  }
+
+  PyObject *list = PyList_New(0);
+  if (list == NULL) {
+    return NULL;
+  }
+
+
+  if (self->receive_bytes <= 0 && timeout != 0) {
+    snd_seq_poll_descriptors(self->handle, self->receive_fds,
+			     self->receive_max, POLLIN);
+    ret = poll(self->receive_fds, self->receive_max, timeout);
+    if (ret == 0) {
+      return list;
+    } else if (ret < 0) {
+      RAISESTR("Failed to poll from receive: %s", strerror(-ret));
+      return NULL;
+    }
+  }
+
+  do {
+    ret = snd_seq_event_input(self->handle, &event);
+    self->receive_bytes = ret;
+    if (ret < 0) {
+      if (ret != -EAGAIN) {
+      }
+      break;
+    }
+
+
+    PyObject *SeqEventObject = SeqEvent_create(event);
+    if (SeqEventObject == NULL) {
+      RAISESTR("Error creating event!");
+      return NULL;
+    }
+
+    PyList_Append(list, SeqEventObject);
+
+    maxevents --;
+
+  } while (maxevents > 0 && ret > 0);
+
+  return list;
+}
+
+/** alsaseq.Sequencer output_event() method: __doc__ */
+const char Sequencer_output_event__doc__ [] =
+  "output_event(event)\n"
+  "\n"
+  "Put the the given event in the outputbuffer. This actually will enqueue\n"
+  "the event, to make sure it's sent, use the drain_output() method.\n"
+  "\n"
+  "Parameters:\n"
+  "  event -- a SeqEvent object\n"
+  "Raises:\n"
+  "  SequencerError: if ALSA can't send the event"
+  ;
+
+/** alsaseq.Sequencer output_event() method */
+static PyObject *
+Sequencer_output_event(SequencerObject *self,
+		       PyObject *args,
+		       PyObject *kwds) {
+  SeqEventObject *seqevent;
+  char *kwlist[] = {"event", NULL};
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "O", kwlist,
+				   &seqevent)) {
+    return NULL;
+  }
+
+  if (!PyObject_TypeCheck(seqevent, &SeqEventType)) {
+    PyErr_SetString(PyExc_TypeError, "alsaseq.SeqEvent expected");
+    return NULL;
+  }
+
+  snd_seq_event_output(self->handle, seqevent->event);
+
+  Py_RETURN_NONE;
+}
+
+/** alsaseq.Sequencer drain_output() method: __doc__ */
+const char Sequencer_drain_output__doc__ [] =
+  "drain_output()\n"
+  "\n"
+  "Drain the output, making sure all events int the buffer are sent.\n"
+  "The events sent may remain unprocessed, to make sure they are\n"
+  "processed, call the sync_output_queue() method.\n"
+  "\n"
+  "Raises:\n"
+  "  SequencerError: if ALSA can't drain the output"
+  ;
+
+/** alsaseq.Sequencer drain_output() method */
+static PyObject *Sequencer_drain_output(SequencerObject *self,
+					PyObject *args) {
+  int ret;
+
+  ret = snd_seq_drain_output(self->handle);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to drain output");
+    return NULL;
+  }
+
+  Py_RETURN_NONE;
+}
+
+/** alsaseq.Sequencer sync_output_queue() method: __doc__ */
+const char Sequencer_sync_output_queue__doc__ [] =
+  "sync_output_queue()\n"
+  "\n"
+  "Waits until all events of this clients are processed.\n"
+  "\n"
+  "Raises:\n"
+  "  SequencerError: if an ALSA error occurs."
+  ;
+
+/** alsaseq.Sequencer sync_output_queue() method */
+static PyObject *
+Sequencer_sync_output_queue(SequencerObject *self,
+			    PyObject *args) {
+  int ret;
+
+  ret = snd_seq_sync_output_queue(self->handle);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to sync output queue");
+    return NULL;
+  }
+
+  Py_RETURN_NONE;
+}
+
+
+/** alsaseq.Sequencer parse_address() method: __doc__ */
+const char Sequencer_parse_address__doc__ [] =
+  "parse_address(string) -> tuple\n"
+  "\n"
+  "Parses the given string as an ALSA client:port. You can use client,\n"
+  "port id's or names.\n"
+  "\n"
+  "Parameters:\n"
+  "  string -- the address in the format client:port.\n"
+  "Returns:\n"
+  "  the tuple (client_id, port_id).\n"
+  "Raises:\n"
+  "  SequencerError: if ALSA can't parse the given address"
+  ;
+
+/** alsaseq.Sequencer parse_address() method */
+static PyObject *
+Sequencer_parse_address(SequencerObject *self,
+			PyObject *args) {
+  snd_seq_addr_t addr;
+  char *str = NULL;
+  int ret;
+
+  if (!PyArg_ParseTuple(args, "s", &(str))) {
+    return NULL;
+  }
+
+  ret = snd_seq_parse_address(self->handle, &addr, str);
+  if (ret < 0) {
+    RAISESND(ret, "Invalid client:port specification '%s'", str);
+    return NULL;
+  }
+
+  PyObject *tuple = PyTuple_New(2);
+  PyTuple_SetItem(tuple, 0, PyInt_FromLong(addr.client));
+  PyTuple_SetItem(tuple, 1, PyInt_FromLong(addr.port));
+
+  return tuple;
+}
+
+/** alsaseq.Sequencer create_queue() method: __doc__ */
+const char Sequencer_create_queue__doc__ [] =
+  "create_queue(name=None)-> int\n"
+  "\n"
+  "Creates a queue with the optional given name.\n"
+  "\n"
+  "Parameters:\n"
+  "  name -- the name of the queue.\n"
+  "Returns:\n"
+  "  the queue id.\n"
+  "Raises:\n"
+  "  SequencerError: if ALSA can't create the queue"
+  ;
+
+/** alsaseq.Sequencer create_queue() method */
+static PyObject *
+Sequencer_create_queue(SequencerObject *self,
+		       PyObject *args,
+		       PyObject *kwds) {
+  char *kwlist[] = {"name", NULL};
+  char *queue_name = NULL;
+  int ret;
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "|s", kwlist,
+				   &queue_name)) {
+    return NULL;
+  }
+
+  if (queue_name != NULL) {
+    ret = snd_seq_alloc_named_queue(self->handle, queue_name);
+  } else {
+    ret = snd_seq_alloc_queue(self->handle);
+  }
+
+  if (ret < 0) {
+    RAISESND(ret, "Failed to create queue");
+    return NULL;
+  }
+
+  return PyInt_FromLong(ret);
+}
+
+/** alsaseq.Sequencer delete_queue() method: __doc__ */
+const char Sequencer_delete_queue__doc__ [] =
+  "delete_queue(queue)\n"
+  "\n"
+  "Deletes (frees) a queue.\n"
+  "\n"
+  "Parameters:\n"
+  "  queue -- the queue id.\n"
+  "Raises:\n"
+  "  SequencerError: if ALSA can't delete the queue."
+  ;
+
+/** alsaseq.Sequencer delete_queue() method */
+static PyObject *
+Sequencer_delete_queue(SequencerObject *self,
+		       PyObject *args,
+		       PyObject *kwds) {
+  char *kwlist[] = {"queue", NULL};
+  int queue_id;
+  int ret;
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "i", kwlist,
+				   &queue_id)) {
+    return NULL;
+  }
+
+  ret = snd_seq_free_queue(self->handle, queue_id);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to create queue");
+    return NULL;
+  }
+
+  Py_RETURN_NONE;
+}
+
+
+/** alsaseq.Sequencer queue_tempo() method: __doc__ */
+const char Sequencer_queue_tempo__doc__ [] =
+  "queue_tempo(queue, tempo=None, ppq=None) -> tuple"
+  "\n"
+  "Query and changes the queue tempo. For querying (not changing) the queue\n"
+  "tempo, pass only the queue id.\n"
+  "\n"
+  "Parameters:\n"
+  "  queue -- the queue id.\n"
+  "  tempo -- the new queue tempo or None for keeping the current tempo.\n"
+  "  ppq -- the new queue ppq or None for keeping the current tempo.\n"
+  "Returns:\n"
+  "  a tuple (tempo, ppq) with the current or changed tempo.\n"
+  "Raises:\n"
+  "  SequencerError: if ALSA can't change the queue tempo or an invalid\n"
+  "                  queue was specified."
+  ;
+
+/** alsaseq.Sequencer queue_tempo() method */
+static PyObject *
+Sequencer_queue_tempo(SequencerObject *self,
+		      PyObject *args,
+		      PyObject *kwds) {
+  char *kwlist[] = {"queue", "tempo", "ppq", NULL};
+  int queueid, tempo=-1, ppq=-1;
+  int ret;
+  snd_seq_queue_tempo_t *queue_tempo;
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "i|ii", kwlist,
+				   &queueid, &tempo, &ppq)) {
+    return NULL;
+  }
+
+  snd_seq_queue_tempo_alloca(&queue_tempo);
+  ret = snd_seq_get_queue_tempo(self->handle, queueid, queue_tempo);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to retrieve current queue tempo");
+    return NULL;
+  }
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "i|ii", kwlist,
+				   &queueid, &tempo, &ppq)) {
+    return NULL;
+  }
+
+  if (tempo != -1) {
+    snd_seq_queue_tempo_set_tempo(queue_tempo, tempo);
+  }
+  if (ppq != -1) {
+    snd_seq_queue_tempo_set_ppq(queue_tempo, ppq);
+  }
+
+  if (tempo != -1 && ppq != -1) {
+    ret = snd_seq_set_queue_tempo(self->handle, queueid, queue_tempo);
+    if (ret < 0) {
+      RAISESND(ret, "Failed to set queue tempo");
+      return NULL;
+    }
+  }
+
+  tempo = snd_seq_queue_tempo_get_tempo(queue_tempo);
+  ppq = snd_seq_queue_tempo_get_ppq(queue_tempo);
+
+  PyObject *tuple = PyTuple_New(2);
+  PyTuple_SetItem(tuple, 0, PyInt_FromLong(tempo));
+  PyTuple_SetItem(tuple, 1, PyInt_FromLong(ppq));
+
+  return tuple;
+}
+
+/** alsaseq.Sequencer start_queue() method: __doc__ */
+const char Sequencer_start_queue__doc__ [] =
+  "start_queue(queue)\n"
+  "\n"
+  "Starts the specified queue.\n"
+  "\n"
+  "Parameters:\n"
+  "  queue -- the queue id.\n"
+  "Raises:\n"
+  "  SequencerError: if ALSA can't start the queue."
+  ;
+
+/** alsaseq.Sequencer start_queue() method */
+static PyObject *
+Sequencer_start_queue(SequencerObject *self,
+		      PyObject *args,
+		      PyObject *kwds) {
+  char *kwlist[] = {"queue", NULL};
+  int queueid;
+  int ret;
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "i", kwlist,
+				   &queueid)) {
+    return NULL;
+  }
+
+  ret = snd_seq_start_queue(self->handle, queueid, NULL);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to start queue");
+    return NULL;
+  }
+
+  Py_RETURN_NONE;
+}
+
+/** alsaseq.Sequencer stop_queue() method: __doc__ */
+const char Sequencer_stop_queue__doc__ [] =
+  "stop_queue(queue)\n"
+  "\n"
+  "Stops the specified queue.\n"
+  "\n"
+  "Parameters:\n"
+  "  queue -- the queue id.\n"
+  "Raises:\n"
+  "  SequencerError: if ALSA can't stop the queue."
+  ;
+
+/** alsaseq.Sequencer stop_queue() method */
+static PyObject *
+Sequencer_stop_queue(SequencerObject *self,
+		      PyObject *args,
+		      PyObject *kwds) {
+  char *kwlist[] = {"queue", NULL};
+  int queueid;
+  int ret;
+
+  if (!PyArg_ParseTupleAndKeywords(args, kwds, "i", kwlist,
+				   &queueid)) {
+    return NULL;
+  }
+
+  ret = snd_seq_stop_queue(self->handle, queueid, NULL);
+  if (ret < 0) {
+    RAISESND(ret, "Failed to stop queue");
+    return NULL;
+  }
+
+  Py_RETURN_NONE;
+}
+
+
+
+
+/** alsaseq.Sequencer tp_methods */
+static PyMethodDef Sequencer_methods[] = {
+  {"create_simple_port",
+   (PyCFunction) Sequencer_create_simple_port,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_create_simple_port__doc__ },
+  {"connection_list",
+   (PyCFunction) Sequencer_connection_list,
+   METH_VARARGS,
+   Sequencer_connection_list__doc__ },
+  {"get_client_info",
+   (PyCFunction) Sequencer_get_client_info,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_get_client_info__doc__ },
+  {"get_port_info",
+   (PyCFunction) Sequencer_get_port_info,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_get_port_info__doc__ },
+  {"connect_ports",
+   (PyCFunction) Sequencer_connect_ports,
+   METH_VARARGS,
+   Sequencer_connect_ports__doc__ },
+  {"disconnect_ports",
+   (PyCFunction) Sequencer_disconnect_ports,
+   METH_VARARGS,
+   Sequencer_disconnect_ports__doc__ },
+  {"get_connect_info",
+   (PyCFunction) Sequencer_get_connect_info,
+   METH_VARARGS,
+   Sequencer_get_connect_info__doc__},
+  {"receive_events",
+   (PyCFunction) Sequencer_receive_events,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_receive_events__doc__},
+  {"output_event",
+   (PyCFunction) Sequencer_output_event,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_output_event__doc__},
+  {"drain_output",
+   (PyCFunction) Sequencer_drain_output,
+   METH_VARARGS,
+   Sequencer_drain_output__doc__},
+  {"sync_output_queue",
+   (PyCFunction) Sequencer_sync_output_queue,
+   METH_VARARGS,
+   Sequencer_sync_output_queue__doc__},
+  {"parse_address",
+   (PyCFunction) Sequencer_parse_address,
+   METH_VARARGS,
+   Sequencer_parse_address__doc__},
+  {"create_queue",
+   (PyCFunction) Sequencer_create_queue,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_create_queue__doc__},
+  {"delete_queue",
+   (PyCFunction) Sequencer_delete_queue,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_delete_queue__doc__},
+  {"queue_tempo",
+   (PyCFunction) Sequencer_queue_tempo,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_queue_tempo__doc__},
+  {"start_queue",
+   (PyCFunction) Sequencer_start_queue,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_start_queue__doc__},
+  {"stop_queue",
+   (PyCFunction) Sequencer_stop_queue,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_stop_queue__doc__},
+  {NULL}
+};
+
+/** alsaseq.Sequencer type */
+static PyTypeObject SequencerType = {
+  PyObject_HEAD_INIT(NULL)
+  tp_name: "alsaseq.Sequencer",
+  tp_basicsize: sizeof(SequencerObject),
+  tp_dealloc: (destructor) Sequencer_dealloc,
+  tp_flags: Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE,
+  tp_doc: Sequencer__doc__,
+  tp_init: (initproc) Sequencer_init,
+  tp_new: PyType_GenericNew,
+  tp_alloc: PyType_GenericAlloc,
+  tp_free: PyObject_Del,
+  tp_repr: (reprfunc) Sequencer_repr,
+  tp_methods: Sequencer_methods,
+  tp_getset: Sequencer_getset
+};
+
+
+
+
+
+//////////////////////////////////////////////////////////////////////////////
+// alsaseq module implementation
+//////////////////////////////////////////////////////////////////////////////
+
+/** alsaseq module: __doc__ */
+const char alsaseq__doc__ [] =
+  "libasound alsaseq wrapper"
+  ;
+
+/** alsaseq module methods */
+static PyMethodDef alsaseq_methods[] = {
+  { NULL },
+};
+
+PyMODINIT_FUNC
+initalsaseq(void) {
+  PyObject *module;
+
+  if (PyType_Ready(&ConstantType) < 0) {
+    return;
+  }
+
+  if (PyType_Ready(&SeqEventType) < 0) {
+    return;
+  }
+
+  if (PyType_Ready(&SequencerType) < 0) {
+    return;
+  }
+
+  module = Py_InitModule3("alsaseq", alsaseq_methods, alsaseq__doc__);
+
+  if (module == NULL) {
+    return;
+  }
+
+  SequencerError = PyErr_NewException("alsaseq.SequencerError", NULL, NULL);
+  if (SequencerError == NULL) {
+    return;
+  }
+
+  Py_INCREF(SequencerError);
+  PyModule_AddObject(module, "SequencerError", SequencerError);
+
+  Py_INCREF(&SeqEventType);
+  PyModule_AddObject(module, "SeqEvent", (PyObject *) &SeqEventType);
+
+  Py_INCREF(&SequencerType);
+  PyModule_AddObject(module, "Sequencer", (PyObject *) &SequencerType);
+
+  Py_INCREF(&ConstantType);
+  PyModule_AddObject(module, "Constant", (PyObject *) &ConstantType);
+
+  /* misc constants */
+  PyModule_AddStringConstant(module,
+			     "SEQ_LIB_VERSION_STR",
+			     SND_LIB_VERSION_STR);
+
+  /* add Constant dictionaries to module */
+  TCONSTDICTADD(module, STREAMS,
+		"_dstreams");
+  TCONSTDICTADD(module, MODE,
+		"_dmode");
+  TCONSTDICTADD(module, QUEUE,
+		"_dqueue");
+  TCONSTDICTADD(module, CLIENT_TYPE,
+		"_dclienttype");
+  TCONSTDICTADD(module, PORT_CAP,
+		"_dportcap");
+  TCONSTDICTADD(module, PORT_TYPE,
+		"_dporttype");
+  TCONSTDICTADD(module, EVENT_TYPE,
+		"_deventtype");
+  TCONSTDICTADD(module, EVENT_TIMESTAMP,
+		"_deventtimestamp");
+  TCONSTDICTADD(module, EVENT_TIMEMODE,
+		"_deventtimemode");
+  TCONSTDICTADD(module, ADDR_CLIENT,
+		"_dclient");
+  TCONSTDICTADD(module, ADDR_PORT,
+		"_dport");
+
+  /* Sequencer streams */
+  TCONSTADD(module, STREAMS,
+	    "SEQ_OPEN_OUTPUT",
+	    SND_SEQ_OPEN_OUTPUT);
+  TCONSTADD(module, STREAMS,
+	    "SEQ_OPEN_INPUT",
+	    SND_SEQ_OPEN_INPUT);
+  TCONSTADD(module, STREAMS,
+	    "SEQ_OPEN_DUPLEX",
+	    SND_SEQ_OPEN_DUPLEX);
+
+  /* Sequencer blocking mode */
+  TCONSTADD(module, MODE,
+	    "SEQ_BLOCK",
+	    0);
+  TCONSTADD(module, MODE,
+	    "SEQ_NONBLOCK",
+	    SND_SEQ_NONBLOCK);
+
+  /* Known queue id */
+  TCONSTADD(module, QUEUE,
+	    "SEQ_QUEUE_DIRECT",
+	    SND_SEQ_QUEUE_DIRECT);
+
+  /* client types */
+  TCONSTADD(module, CLIENT_TYPE,
+	    "SEQ_USER_CLIENT",
+	    SND_SEQ_USER_CLIENT);
+  TCONSTADD(module, CLIENT_TYPE,
+	    "SEQ_KERNEL_CLIENT",
+	    SND_SEQ_KERNEL_CLIENT);
+
+  /* Sequencer port cap */
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_NONE",
+	    0);
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_WRITE",
+	    SND_SEQ_PORT_CAP_WRITE);
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_SYNC_WRITE",
+	    SND_SEQ_PORT_CAP_SYNC_WRITE);
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_SYNC_READ",
+	    SND_SEQ_PORT_CAP_SYNC_READ);
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_SUBS_WRITE",
+	    SND_SEQ_PORT_CAP_SUBS_WRITE);
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_SUBS_READ",
+	    SND_SEQ_PORT_CAP_SUBS_READ);
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_READ",
+	    SND_SEQ_PORT_CAP_READ);
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_NO_EXPORT",
+	    SND_SEQ_PORT_CAP_NO_EXPORT);
+  TCONSTADD(module, PORT_CAP,
+	    "SEQ_PORT_CAP_DUPLEX",
+	    SND_SEQ_PORT_CAP_DUPLEX);
+
+  /* Sequencer port type */
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_SYNTHESIZER",
+	    SND_SEQ_PORT_TYPE_SYNTHESIZER);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_SYNTH",
+	    SND_SEQ_PORT_TYPE_SYNTH);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_SPECIFIC",
+	    SND_SEQ_PORT_TYPE_SPECIFIC);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_SOFTWARE",
+	    SND_SEQ_PORT_TYPE_SOFTWARE);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_SAMPLE",
+	    SND_SEQ_PORT_TYPE_SAMPLE);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_PORT",
+	    SND_SEQ_PORT_TYPE_PORT);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_MIDI_XG",
+	    SND_SEQ_PORT_TYPE_MIDI_XG);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_MIDI_MT32",
+	    SND_SEQ_PORT_TYPE_MIDI_MT32);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_MIDI_GS",
+	    SND_SEQ_PORT_TYPE_MIDI_GS);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_MIDI_GM2",
+	    SND_SEQ_PORT_TYPE_MIDI_GM2);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_MIDI_GM",
+	    SND_SEQ_PORT_TYPE_MIDI_GM);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_MIDI_GENERIC",
+	    SND_SEQ_PORT_TYPE_MIDI_GENERIC);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_HARDWARE",
+	    SND_SEQ_PORT_TYPE_HARDWARE);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_DIRECT_SAMPLE",
+	    SND_SEQ_PORT_TYPE_DIRECT_SAMPLE);
+  TCONSTADD(module, PORT_TYPE,
+	    "SEQ_PORT_TYPE_APPLICATION",
+	    SND_SEQ_PORT_TYPE_APPLICATION);
+
+  /* SeqEvent event type */
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SYSTEM",
+	    SND_SEQ_EVENT_SYSTEM);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_RESULT",
+	    SND_SEQ_EVENT_RESULT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_NOTE",
+	    SND_SEQ_EVENT_NOTE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_NOTEON",
+	    SND_SEQ_EVENT_NOTEON);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_NOTEOFF",
+	    SND_SEQ_EVENT_NOTEOFF);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_KEYPRESS",
+	    SND_SEQ_EVENT_KEYPRESS);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_CONTROLLER",
+	    SND_SEQ_EVENT_CONTROLLER);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_PGMCHANGE",
+	    SND_SEQ_EVENT_PGMCHANGE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_CHANPRESS",
+	    SND_SEQ_EVENT_CHANPRESS);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_PITCHBEND",
+	    SND_SEQ_EVENT_PITCHBEND);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_CONTROL14",
+	    SND_SEQ_EVENT_CONTROL14);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_NONREGPARAM",
+	    SND_SEQ_EVENT_NONREGPARAM);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_REGPARAM",
+	    SND_SEQ_EVENT_REGPARAM);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SONGPOS",
+	    SND_SEQ_EVENT_SONGPOS);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SONGSEL",
+	    SND_SEQ_EVENT_SONGSEL);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_QFRAME",
+	    SND_SEQ_EVENT_QFRAME);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_TIMESIGN",
+	    SND_SEQ_EVENT_TIMESIGN);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_KEYSIGN",
+	    SND_SEQ_EVENT_KEYSIGN);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_START",
+	    SND_SEQ_EVENT_START);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_CONTINUE",
+	    SND_SEQ_EVENT_CONTINUE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_STOP",
+	    SND_SEQ_EVENT_STOP);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SETPOS_TICK",
+	    SND_SEQ_EVENT_SETPOS_TICK);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SETPOS_TIME",
+	    SND_SEQ_EVENT_SETPOS_TIME);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_TEMPO",
+	    SND_SEQ_EVENT_TEMPO);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_CLOCK",
+	    SND_SEQ_EVENT_CLOCK);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_TICK",
+	    SND_SEQ_EVENT_TICK);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_QUEUE_SKEW",
+	    SND_SEQ_EVENT_QUEUE_SKEW);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SYNC_POS",
+	    SND_SEQ_EVENT_SYNC_POS);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_TUNE_REQUEST",
+	    SND_SEQ_EVENT_TUNE_REQUEST);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_RESET",
+	    SND_SEQ_EVENT_RESET);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SENSING",
+	    SND_SEQ_EVENT_SENSING);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_ECHO",
+	    SND_SEQ_EVENT_ECHO);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_OSS",
+	    SND_SEQ_EVENT_OSS);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_CLIENT_START",
+	    SND_SEQ_EVENT_CLIENT_START);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_CLIENT_EXIT",
+	    SND_SEQ_EVENT_CLIENT_EXIT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_CLIENT_CHANGE",
+	    SND_SEQ_EVENT_CLIENT_CHANGE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_PORT_START",
+	    SND_SEQ_EVENT_PORT_START);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_PORT_EXIT",
+	    SND_SEQ_EVENT_PORT_EXIT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_PORT_CHANGE",
+	    SND_SEQ_EVENT_PORT_CHANGE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_PORT_SUBSCRIBED",
+	    SND_SEQ_EVENT_PORT_SUBSCRIBED);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_PORT_UNSUBSCRIBED",
+	    SND_SEQ_EVENT_PORT_UNSUBSCRIBED);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE",
+	    SND_SEQ_EVENT_SAMPLE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE_CLUSTER",
+	    SND_SEQ_EVENT_SAMPLE_CLUSTER);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE_START",
+	    SND_SEQ_EVENT_SAMPLE_START);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE_STOP",
+	    SND_SEQ_EVENT_SAMPLE_STOP);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE_FREQ",
+	    SND_SEQ_EVENT_SAMPLE_FREQ);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE_VOLUME",
+	    SND_SEQ_EVENT_SAMPLE_VOLUME);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE_LOOP",
+	    SND_SEQ_EVENT_SAMPLE_LOOP);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE_POSITION",
+	    SND_SEQ_EVENT_SAMPLE_POSITION);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SAMPLE_PRIVATE1",
+	    SND_SEQ_EVENT_SAMPLE_PRIVATE1);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR0",
+	    SND_SEQ_EVENT_USR0);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR1",
+	    SND_SEQ_EVENT_USR1);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR2",
+	    SND_SEQ_EVENT_USR2);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR3",
+	    SND_SEQ_EVENT_USR3);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR4",
+	    SND_SEQ_EVENT_USR4);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR5",
+	    SND_SEQ_EVENT_USR5);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR6",
+	    SND_SEQ_EVENT_USR6);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR7",
+	    SND_SEQ_EVENT_USR7);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR8",
+	    SND_SEQ_EVENT_USR8);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR9",
+	    SND_SEQ_EVENT_USR9);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_BEGIN",
+	    SND_SEQ_EVENT_INSTR_BEGIN);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_END",
+	    SND_SEQ_EVENT_INSTR_END);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_INFO",
+	    SND_SEQ_EVENT_INSTR_INFO);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_INFO_RESULT",
+	    SND_SEQ_EVENT_INSTR_INFO_RESULT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_FINFO",
+	    SND_SEQ_EVENT_INSTR_FINFO);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_FINFO_RESULT",
+	    SND_SEQ_EVENT_INSTR_FINFO_RESULT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_RESET",
+	    SND_SEQ_EVENT_INSTR_RESET);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_STATUS",
+	    SND_SEQ_EVENT_INSTR_STATUS);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_STATUS_RESULT",
+	    SND_SEQ_EVENT_INSTR_STATUS_RESULT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_PUT",
+	    SND_SEQ_EVENT_INSTR_PUT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_GET",
+	    SND_SEQ_EVENT_INSTR_GET);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_GET_RESULT",
+	    SND_SEQ_EVENT_INSTR_GET_RESULT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_FREE",
+	    SND_SEQ_EVENT_INSTR_FREE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_LIST",
+	    SND_SEQ_EVENT_INSTR_LIST);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_LIST_RESULT",
+	    SND_SEQ_EVENT_INSTR_LIST_RESULT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_CLUSTER",
+	    SND_SEQ_EVENT_INSTR_CLUSTER);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_CLUSTER_GET",
+	    SND_SEQ_EVENT_INSTR_CLUSTER_GET);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_CLUSTER_RESULT",
+	    SND_SEQ_EVENT_INSTR_CLUSTER_RESULT);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_INSTR_CHANGE",
+	    SND_SEQ_EVENT_INSTR_CHANGE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_SYSEX",
+	    SND_SEQ_EVENT_SYSEX);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_BOUNCE",
+	    SND_SEQ_EVENT_BOUNCE);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR_VAR0",
+	    SND_SEQ_EVENT_USR_VAR0);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR_VAR1",
+	    SND_SEQ_EVENT_USR_VAR1);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR_VAR2",
+	    SND_SEQ_EVENT_USR_VAR2);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR_VAR3",
+	    SND_SEQ_EVENT_USR_VAR3);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_USR_VAR4",
+	    SND_SEQ_EVENT_USR_VAR4);
+  TCONSTADD(module, EVENT_TYPE,
+	    "SEQ_EVENT_NONE",
+	    SND_SEQ_EVENT_NONE);
+
+
+  /* SeqEvent event timestamp flags */
+  TCONSTADD(module, EVENT_TIMESTAMP,
+	    "SEQ_TIME_STAMP_TICK",
+	    SND_SEQ_TIME_STAMP_TICK);
+  TCONSTADD(module, EVENT_TIMESTAMP,
+	    "SEQ_TIME_STAMP_REAL",
+	    SND_SEQ_TIME_STAMP_REAL);
+
+  /* SeqEvent event timemode flags */
+  TCONSTADD(module, EVENT_TIMEMODE,
+	    "SEQ_TIME_MODE_ABS",
+	    SND_SEQ_TIME_MODE_ABS);
+  TCONSTADD(module, EVENT_TIMEMODE,
+	    "SEQ_TIME_MODE_REL",
+	    SND_SEQ_TIME_MODE_REL);
+
+  /* SeqEvent event addresses */
+  TCONSTADD(module, ADDR_CLIENT,
+	    "SEQ_CLIENT_SYSTEM",
+	    SND_SEQ_CLIENT_SYSTEM);
+  TCONSTADD(module, ADDR_CLIENT,
+	    "SEQ_ADDRESS_BROADCAST",
+	    SND_SEQ_ADDRESS_BROADCAST);
+  TCONSTADD(module, ADDR_CLIENT,
+	    "SEQ_ADDRESS_SUBSCRIBERS",
+	    SND_SEQ_ADDRESS_SUBSCRIBERS);
+  TCONSTADD(module, ADDR_CLIENT,
+	    "SEQ_ADDRESS_UNKNOWN",
+	    SND_SEQ_ADDRESS_UNKNOWN);
+  TCONSTADD(module, ADDR_PORT,
+	    "SEQ_PORT_SYSTEM_TIMER",
+	    SND_SEQ_PORT_SYSTEM_TIMER);
+  TCONSTADD(module, ADDR_PORT,
+	    "SEQ_PORT_SYSTEM_ANNOUNCE",
+	    SND_SEQ_PORT_SYSTEM_ANNOUNCE);
+  TCONSTADD(module, ADDR_PORT,
+	    "SEQ_ADDRESS_BROADCAST",
+	    SND_SEQ_ADDRESS_BROADCAST);
+  TCONSTADD(module, ADDR_PORT,
+	    "SEQ_ADDRESS_SUBSCRIBERS",
+	    SND_SEQ_ADDRESS_SUBSCRIBERS);
+  TCONSTADD(module, ADDR_PORT,
+	    "SEQ_ADDRESS_UNKNOWN",
+	    SND_SEQ_ADDRESS_UNKNOWN);
+
+}
diff -r 02b11d9f243d setup.py
--- a/setup.py	Tue Jan 22 11:56:20 2008 +0100
+++ b/setup.py	Thu Jan 24 05:18:40 2008 -0300
@@ -45,6 +45,11 @@ setup(
                     include_dirs=[],
                     library_dirs=[],
                     libraries=['asound']),
+          Extension('pyalsa.alsaseq',
+		    ['pyalsa/alsaseq.c'],
+                    include_dirs=[],
+                    library_dirs=[],
+                    libraries=['asound']),
 	],
         packages=['pyalsa'],
         scripts=[]
@@ -52,7 +57,7 @@ setup(

 uname = os.uname()
 a = 'build/lib.%s-%s-%s' % (uname[0].lower(), uname[4], sys.version[:3])
-for f in ['alsacard.so', 'alsacontrol.so', 'alsahcontrol.so', 'alsamixer.so']:
+for f in ['alsacard.so', 'alsacontrol.so', 'alsahcontrol.so',
'alsamixer.so', 'alsaseq.so']:
         if not os.path.exists('pyalsa/%s' % f):
                 a = '../build/lib.%s-%s-%s/pyalsa/%s' % (uname[0].lower(),
                         uname[4], sys.version[:3], f)
diff -r 02b11d9f243d test/aconnect.py
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/aconnect.py	Thu Jan 24 05:18:40 2008 -0300
@@ -0,0 +1,205 @@
+#! /usr/bin/python
+
+# aconnect.py -- python port of aconnect
+# Copyright (C) 2008 Aldrin Martoq <amartoq@dcc.uchile.cl>
+#
+# Based on code from aconnect.c from ALSA project
+# Copyright (C) 1999 Takashi Iwai
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2 as
+#  published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+
+
+import sys
+sys.path.insert(0, '../pyalsa')
+
+import getopt
+import os
+from alsaseq import *
+
+LIST_INPUT=1
+LIST_OUTPUT=2
+
+def errormsg(msg, *args):
+    """ prints an error message to stderr """
+    sys.stderr.write(msg % args)
+    sys.stderr.write('\n')
+    traceback.print_exc(file=sys.stderr)
+
+def fatal(msg, *args):
+    """ prints an error message to stderr, and dies """
+    errormsg(msg, *args)
+    sys.exit(1)
+
+def init_seq():
+    """ opens an alsa sequencer """
+    try:
+        sequencer = Sequencer(name = 'default',
+                              clientname = 'aconnect.py',
+                              streams = SEQ_OPEN_DUPLEX,
+                              mode = SEQ_BLOCK)
+        return sequencer
+    except SequencerError, e:
+        fatal("open sequencer: %e", e)
+
+
+def usage():
+    print  \
+        "aconnect - python ALSA sequencer connection manager\n" \
+        "Copyright (C) 1999-2000 Takashi Iwai\n" \
+        "Copyright (C) 2008 Aldrin Martoq <amartoq@dcc.uchile.cl>\n" \
+        "Usage: \n" \
+        " * Connection/disconnection between ports\n" \
+        "   %s [-options] sender receiver\n" \
+        "     sender, receiver = client:port pair\n" \
+        "     -d,--disconnect     disconnect\n" \
+        "     -e,--exclusive      exclusive connection\n" \
+        "     -r,--real #         convert real-time-stamp on queue\n" \
+        "     -t,--tick #         convert tick-time-stamp on queue\n" \
+        " * List connected ports (no subscription action)\n" \
+        "   %s -i|-o [-options]\n" \
+        "     -i,--input          list input (readable) ports\n" \
+        "     -o,--output         list output (writable) ports\n" \
+        "     -l,--list           list current connections of each port\n" \
+        " * Remove all exported connections\n" \
+        "     -x,--removeall" \
+        % (sys.argv[0], sys.argv[0])
+
+def do_list_subs(conn, text):
+    l = []
+    for c, p, i in conn:
+        s = ""
+        if i['exclusive']:
+            s+= "[ex]"
+        if i['time_update']:
+            if i['time_real']:
+                s += "[%s:%s]" % ("real", i['queue'])
+            else:
+                s += "[%s:%s]" % ("tick", i['queue'])
+        s = "%d:%d%s" % (c, p, s)
+        l.append(s)
+    if len(l):
+        print "\t%s: %s" % (text, ', '.join(l))
+
+
+def do_list_ports(sequencer, list_perm, list_subs):
+    connectionlist = sequencer.connection_list()
+    for connections in connectionlist:
+        clientname, clientid, connectedports = connections
+        clientinfo = sequencer.get_client_info(clientid)
+        type = clientinfo['type']
+        count = []
+        if type == SEQ_USER_CLIENT:
+            type = 'user'
+        else:
+            type = 'kernel'
+        for port in connectedports:
+            portname, portid, portconns = port
+            portinfo = sequencer.get_port_info(portid, clientid)
+            caps = portinfo['capability']
+            if not (caps & SEQ_PORT_CAP_NO_EXPORT):
+                reads = SEQ_PORT_CAP_READ | SEQ_PORT_CAP_SUBS_READ
+                write = SEQ_PORT_CAP_WRITE | SEQ_PORT_CAP_SUBS_WRITE
+                if (list_perm & LIST_INPUT) and (caps & reads == reads):
+                    count.append(port)
+                elif (list_perm & LIST_OUTPUT) and (caps & write == write):
+                    count.append(port)
+        if len(count) > 0:
+            print "client %d: '%s' [type=%s]" % (clientid, clientname, type)
+            for port in count:
+                portname, portid, portconns = port
+                print "  %3d '%-16s'" % (portid, portname)
+                if list_subs:
+                    readconn, writeconn = portconns
+                    do_list_subs(readconn, "Connecting To")
+                    do_list_subs(writeconn, "Connected From")
+
+def do_unsubscribe(sequencer, args):
+    sender = sequencer.parse_address(args[0])
+    dest = sequencer.parse_address(args[1])
+    try:
+        sequencer.get_connect_info(sender, dest)
+    except SequencerError:
+        print 'No subscription is found'
+        return
+    try:
+        sequencer.disconnect_ports(sender, dest)
+    except SequencerError, e:
+        fatal("Failed to disconnect ports %s->%s - %s", sender, dest, e)
+
+def do_subscribe(sequencer, args, queue, exclusive, convert_time,
convert_real):
+    sender = sequencer.parse_address(args[0])
+    dest = sequencer.parse_address(args[1])
+    try:
+        sequencer.get_connect_info(sender, dest)
+        print "Connection is already subscribed"
+        return
+    except SequencerError:
+        pass
+    sequencer.connect_ports(sender, dest, queue, exclusive,
convert_time, convert_real)
+
+def main():
+    sequencer = init_seq()
+    command = 'subscribe'
+    list_perm = 0
+    list_subs = 0
+    exclusive = 0
+    convert_time = 0
+    convert_real = 0
+    queue = 0
+
+    try:
+        opts, args = getopt.getopt(sys.argv[1:], "dior:t:elx",
["disconnect", "input", "output", "real=", "tick=", "exclusive",
"list", "removeall"])
+    except getopt.GetoptError:
+        usage()
+        sys.exit(2)
+    for o, a in opts:
+        if o in ("-d", "--disconnect"):
+            command = 'unsubscribe'
+        elif o in ("-i", "--input"):
+            command = 'list'
+            list_perm |= LIST_INPUT
+        elif o in ("-o", "--output"):
+            command = 'list'
+            list_perm |= LIST_OUTPUT
+        elif o in ("-e", "--exclusive"):
+            exclusive = 1
+        elif o in ("-r", "--real"):
+            queue = int(a)
+            convert_time = 1
+            convert_real = 1
+        elif o in ("-t", "--tick"):
+            queue = int(a)
+            convert_time = 1
+            convert_real = 0
+        elif o in ("-l", "--list"):
+            list_subs = 1
+        elif o in ("-x", "--removeall"):
+            command = 'removeall'
+
+    if command == 'list':
+        do_list_ports(sequencer, list_perm, list_subs)
+        return
+
+    if len(args) != 2:
+        usage()
+        sys.exit(2)
+
+    if command == 'unsubscribe':
+        do_unsubscribe(sequencer, args)
+    elif command == 'subscribe':
+        do_subscribe(sequencer, args, queue, exclusive, convert_time,
convert_real)
+
+
+if __name__ == '__main__':
+    main()
diff -r 02b11d9f243d test/alsamemdebug.py
--- a/test/alsamemdebug.py	Tue Jan 22 11:56:20 2008 +0100
+++ b/test/alsamemdebug.py	Thu Jan 24 05:18:40 2008 -0300
@@ -5,7 +5,8 @@ import gc
 import gc

 def debuginit():
-	gc.set_debug(gc.DEBUG_LEAK)
+	gc.set_debug(gc.DEBUG_LEAK | gc.DEBUG_STATS)
+	print "GC DEBUG: init."

 def debug(what):
 	from sys import getrefcount
@@ -13,7 +14,9 @@ def debug(what):
 	for o in what:
 		if getrefcount(o) - 3 != 1 or \
 		   len(get_referrers(o)) - 2 != 1:
-			print 'LEAK:', hex(id(o)), type(o), getrefcount(o)-3,
len(get_referrers(o))-2
+			print 'GD DEBUG LEAK:', o, hex(id(o)), type(o), getrefcount(o)-3,
len(get_referrers(o))-2

 def debugdone():
+	gc.collect()
+	print "GC DEBUG LEAK done."
 	None
diff -r 02b11d9f243d test/aplaymidi.py
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/aplaymidi.py	Thu Jan 24 05:18:40 2008 -0300
@@ -0,0 +1,501 @@
+#! /usr/bin/python
+
+# aplaymidi.py -- python port of aplaymidi
+# Copyright (C) 2008 Aldrin Martoq <amartoq@dcc.uchile.cl>
+#
+# Based on code from aplaymidi.c from ALSA project
+# Copyright (C) 2004-2006 Clemens Ladisch <clemens@ladisch.de>
+#
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+
+
+import sys
+sys.path.insert(0, '../pyalsa')
+
+import getopt
+import os
+import struct
+import alsaseq
+import traceback
+import time
+from alsaseq import *
+
+class SMFError(Exception):
+    """ Exception raised for errors while reading a SMF file """
+    pass
+
+
+def errormsg(msg, *args):
+    """ prints an error message to stderr """
+    sys.stderr.write(msg % args)
+    sys.stderr.write('\n')
+    traceback.print_exc(file=sys.stderr)
+
+
+def fatal(msg, *args):
+    """ prints an error message to stderr, and dies """
+    errormsg(msg, *args)
+    sys.exit(1)
+
+
+def init_seq():
+    """ opens an alsa sequencer """
+    try:
+        sequencer = Sequencer(name = 'default',
+                              clientname = 'aplaymidi.py',
+                              streams = SEQ_OPEN_DUPLEX,
+                              mode = SEQ_BLOCK)
+        return sequencer
+    except SequencerError, e:
+        fatal("open sequencer: %e", e)
+
+
+def parse_ports(sequencer, portspec):
+    """ parses one or more port addresses from the string, separated by ','
+    example: 14:0,Timidity
+    """
+    portlist = []
+    if portspec == None:
+        return portlist
+    ports = portspec.split(',')
+    for port in ports:
+        try:
+            client, port = sequencer.parse_address(port)
+            portlist.append((client, port))
+        except SequencerError, e:
+            fatal("Failed to parse port %s - %s", port, e)
+    return portlist
+
+
+def create_source_port(sequencer):
+    try :
+        port = sequencer.create_simple_port(name = 'aplaymidi.py',
+                                            type = SEQ_PORT_TYPE_MIDI_GENERIC \
+                                                | SEQ_PORT_TYPE_APPLICATION,
+                                            caps = SEQ_PORT_CAP_NONE)
+        return port
+    except SequencerError, e:
+        fatal("Failed to create port - %s", e)
+
+
+def create_queue(sequencer):
+    try:
+        queue = sequencer.create_queue(name = 'aplaymidi')
+        return queue
+    except SequencerError, e:
+        fatal("Failed to create queue - %s", e)
+
+
+def connect_ports(sequencer, port_id, ports):
+    client_id = sequencer.client_id
+    for client, port in ports:
+        sequencer.connect_ports((client_id, port_id), (client, port))
+
+
+def read_byte(file):
+    """ read a single byte
+    raises SMFError if end of file was detected
+    """
+    s = file.read(1)
+    if s == '':
+        raise SMFError('End of file reached at position %d' % file.tell())
+    return struct.unpack('B', s)[0]
+
+
+def read_32_le(file):
+    """ reads a little-endian 32-bit integer """
+    value = 0
+    for p in (0, 8, 16, 24):
+        c = read_byte(file)
+        value |= c << p
+    return value
+
+
+def read_id(file):
+    """ reads a 4-char identifier """
+    return file.read(4)
+
+
+def read_int(file, bytes):
+    """ reads a fixed-size big-endian number """
+    value = 0
+    while bytes > 0:
+        c = read_byte(file)
+        value = (value << 8) | c
+        bytes -= 1
+    return value
+
+
+def read_var(file):
+    """ reads a variable-length number """
+    c = read_byte(file)
+    value = c & 0x7f
+    if c & 0x80:
+        c = read_byte(file)
+        value = (value << 7) | (c & 0x7f)
+        if c & 0x80:
+            c = read_byte(file)
+            value = (value << 7) | (c & 0x7f)
+            if c & 0x80:
+                c = read_byte(file)
+                value = (value << 7) | (c & 0x7f)
+                if c & 0x80:
+                    raise SMFError('Invalid variable-length number at
file position %d' % file.tell())
+    return value
+
+def skip(file, bytes):
+    """ skip the specified number of bytes """
+    file.read(bytes)
+
+
+def read_track(file, chunk_len, ports, smtpe_timing):
+    """ reads one complete track from the file """
+
+    tick = 0
+    last_cmd = 0
+    port = 0
+    typemap = {}
+    typemap[0x8] = SEQ_EVENT_NOTEOFF
+    typemap[0x9] = SEQ_EVENT_NOTEON
+    typemap[0xa] = SEQ_EVENT_KEYPRESS
+    typemap[0xb] = SEQ_EVENT_CONTROLLER
+    typemap[0xc] = SEQ_EVENT_PGMCHANGE
+    typemap[0xd] = SEQ_EVENT_CHANPRESS
+    typemap[0xe] = SEQ_EVENT_PITCHBEND
+
+    eventlist = []
+
+    track_end = file.tell() + chunk_len
+    while file.tell() < track_end:
+        delta_ticks = read_var(file)
+        if delta_ticks < 0:
+            break
+        tick += delta_ticks
+
+        c = read_byte(file)
+
+        if c < 0:
+            break
+
+        if c & 0x80:
+            cmd = c
+            if cmd < 0xf0:
+                last_cmd = cmd
+        else:
+            # running status
+            cmd = last_cmd
+            file.seek(file.tell() - 1)
+            if not cmd:
+                break
+
+
+        s = cmd >> 4
+        if s >= 0x8 and s <= 0xa:
+            event = SeqEvent(type=typemap[s])
+            event.dest = ports[port]
+            event.time = tick
+            event.set_data({'note.channel' : cmd & 0x0f,
+                           'note.note' : read_byte(file) & 0x7f,
+                           'note.velocity' : read_byte(file) & 0x7f
+                           })
+            eventlist.append(event)
+        elif s == 0xb or s == 0xe:
+            event = SeqEvent(type=typemap[s])
+            event.dest = ports[port]
+            event.time = tick
+            event.set_data({'control.channel' : cmd & 0x0f,
+                           'control.param' : read_byte(file) & 0x7f,
+                           'control.value' : read_byte(file) & 0x7f
+                           })
+            eventlist.append(event)
+        elif s == 0xc or s == 0xd:
+            event = SeqEvent(type=typemap[s])
+            event.dest = ports[port]
+            event.time = tick
+            event.set_data({'control.channel' : cmd & 0x0f,
+                           'control.value' : read_byte(file) & 0x7f
+                           })
+            eventlist.append(event)
+        elif s == 0xf:
+            if cmd == 0xf0 or cmd == 0xf7:
+                # sysex
+                l = read_var(file)
+                if l < 0:
+                    break
+                if cmd == 0xf0:
+                    l += 1
+                event = SeqEvent(type=SEQ_EVENT_SYSEX)
+                event.dest = ports[port]
+                event.time = tick
+                sysexdata = []
+                if cmd == 0xf0:
+                    sysexdata.append(0xf0)
+                while len(sysexdata) < l:
+                    sysexdata.append(read_byte(file))
+                event.set_data({'ext' : sysexdata})
+                eventlist.append(event)
+            elif cmd == 0xff:
+                c = read_byte(file)
+                l = read_var(file)
+                if l < 0:
+                    break
+                if c == 0x21:
+                    # port number
+                    port = read_byte() % len(ports)
+                    skip(file, l - 1)
+                elif c == 0x2f:
+                    # end track
+                    track_endtick = tick
+                    skip(file, track_end - file.tell())
+                    return track_endtick, eventlist
+                elif c == 0x51:
+                    # tempo
+                    if l < 3:
+                        break
+                    if smtpe_timing:
+                        skip(file, l)
+                    else:
+                        event = SeqEvent(type=SEQ_EVENT_TEMPO)
+                        event.dest = (SEQ_CLIENT_SYSTEM, SEQ_PORT_SYSTEM_TIMER)
+                        event.time = tick
+                        tempo = read_byte(file) << 16
+                        tempo |= read_byte(file) << 8
+                        tempo |= read_byte(file)
+                        event.set_data({'queue.param.value' : tempo})
+                        eventlist.append(event)
+                        skip(file, l - 3)
+                else:
+                    # ignore all other meta events
+                    skip(file, l)
+            else:
+                break
+        else:
+            break
+
+    raise SMFError('Invalid MIDI data at file position (%d)' % file.tell())
+
+def read_smf(file, ports):
+    """ reads an entire MIDI file """
+
+    tempo = 0
+    ppq = 0
+    tracks = []
+
+
+    header_len = read_int(file, 4)
+    if header_len < 6:
+        raise SMFError('Invalid header_len: %d' % header_len)
+
+    type = read_int(file, 2)
+    if type != 0 and type != 1:
+        raise SMFError('Not supported type: %d' % type)
+
+    num_tracks = read_int(file, 2)
+    if num_tracks < 1 or num_tracks > 1000:
+        raise SMFError('Invalid number of tracks: %d' % num_tracks)
+
+    time_division = read_int(file, 2)
+    if time_division < 0:
+        raise SMFError('Invalid time division: %d' % time_division)
+
+    smtpe_timing = time_division & 0x8000
+
+    if not smtpe_timing:
+        # time division is ticks per quarter
+        tempo = 500000
+        ppq = time_division
+    else:
+        i = 0x80 - ((time_division >>8) & 0x7f)
+        time_division &= 0xff
+        if i == 24:
+            tempo = 500000
+            ppq = 12 * time_division
+        elif i == 25:
+            tempo = 400000
+            ppq = 10 * time_division
+        elif i == 29:
+            tempo = 100000000
+            ppq = 2997 * time_division
+        elif i == 30:
+            tempo = 500000
+            ppq = 15 * time_division
+        else:
+            raise SMFError('Invalid number of SMPTE frames per second (%d)'
+                           % i)
+
+    # read tracks
+    while num_tracks > 0:
+        # search for MTrk chunk
+        while True:
+            id = read_id(file)
+            chunk_len = read_int(file, 4)
+            if chunk_len < 0 or chunk_len >= 0x10000000:
+                raise SMFError('Invalid chunk length %d' % chunk_len)
+            if id == 'MTrk':
+                break
+            skip(file, chunk_len)
+        trackevents = read_track(file, chunk_len, ports, smtpe_timing)
+        tracks.append(trackevents)
+        num_tracks -= 1
+
+    return tempo, ppq, tracks
+
+def read_riff(file, ports):
+    """ reads an entire RIFF file """
+
+    raise NotImplementedError("Sorry, I couldn't find any RIFF midi
file to implement this!  -- Aldrin Martoq")
+
+
+def play(sequencer, filename, end_delay, source_port, queue, ports):
+    file = sys.stdin
+    ok = None
+    if filename != '-':
+        try:
+            file = open(filename, 'rb')
+        except IOError, e:
+            fatal("Cannot open %s - %s", filename, e)
+
+    id = read_id(file)
+    try:
+        if id == 'MThd':
+            ok = read_smf(file, ports)
+        elif id == 'RIFF':
+            ok = read_riff(file, ports)
+        else:
+            raise SMFError('unrecognized id')
+    except SMFError, e:
+        errormsg("%s is not a Standard MIDI File - %s", filename, e)
+
+    # now play!
+    tempo, ppq, tracks = ok
+    sequencer.queue_tempo(queue, tempo, ppq)
+    sequencer.start_queue(queue)
+
+    # add all events from tracks and sort them based on track, then on time
+    itrack = 0
+    allevents = []
+    for track in tracks:
+        endtick, eventlist = track
+        for event in eventlist:
+            d = {'itrack' : itrack, 'event' : event, 'time' : event.time}
+            allevents.append(d)
+        itrack += 1
+    def compare(x, y):
+        ret = x['time'] - y['time']
+        if ret == 0:
+            ret = x['itrack'] - y['itrack']
+        return ret
+    allevents.sort(compare)
+    max_tick = allevents[-1]['time']
+
+    for d in allevents:
+        event = d['event']
+        event.source = (0, 0)
+        event.queue = queue
+        if event.type == SEQ_EVENT_TEMPO:
+            event.set_data({'queue.queue' : queue})
+        sequencer.output_event(event)
+
+    # schedule queue stop at end of song
+    event = SeqEvent(SEQ_EVENT_STOP)
+    event.source = (0, 0)
+    event.queue = queue
+    event.time = max_tick
+    event.dest = (SEQ_CLIENT_SYSTEM, SEQ_PORT_SYSTEM_TIMER)
+    event.set_data({'queue.queue' : queue})
+    sequencer.output_event(event)
+
+    # make sure that the sequencer sees all our events
+    sequencer.drain_output()
+    sequencer.sync_output_queue()
+
+    time.sleep(end_delay)
+
+    if file != sys.stdin:
+        file.close()
+
+
+
+def list_ports():
+    sequencer = init_seq()
+    print " Port    Client name                      Port name";
+    clientports = sequencer.connection_list()
+    for connections in clientports:
+        clientname, clientid, connectedports = connections
+        for port in connectedports:
+            portname, portid, connections = port
+            portinfo = sequencer.get_port_info(portid, clientid)
+            type = portinfo['type']
+            caps = portinfo['capability']
+            if type & SEQ_PORT_TYPE_MIDI_GENERIC and \
+                    caps & (SEQ_PORT_CAP_WRITE | SEQ_PORT_CAP_SUBS_WRITE):
+                print "%3d:%-3d  %-32.32s %s" % (clientid, portid,
clientname, portname)
+
+def usage():
+    print "Usage: %s -p client:port[,...] [-d delay] midifile ...\n" \
+        "-h, --help                  this help\n" \
+        "-V, --version               print current version\n" \
+        "-l, --list                  list all possible output ports\n" \
+        "-p, --port=client:port,...  set port(s) to play to\n" \
+        "-d, --delay=seconds         delay after song ends\n" % (sys.argv[0])
+
+def version():
+    print "aplaymidi.py asoundlib version %s" % (SEQ_LIB_VERSION_STR)
+
+
+def main():
+    sequencer = init_seq()
+    ports = []
+    end_delay = 2
+
+    try:
+        opts, args = getopt.getopt(sys.argv[1:], "hVlp:d:", ["help",
"version", "list", "port=", "delay="])
+    except getopt.GetoptError:
+        usage()
+        sys.exit(2)
+    for o, a in opts:
+        if o in ("-h", "--help"):
+            usage()
+            sys.exit(0)
+        elif o in ("-V", "--version"):
+            version()
+            sys.exit(0)
+        elif o in ("-l", "--list"):
+            list_ports()
+            sys.exit(0)
+        elif o in ("-p", "--port"):
+            ports = parse_ports(sequencer, a)
+        elif o in ("-d", "--delay"):
+            end_delay = int(a)
+
+    if len(ports) < 1:
+        ports = parse_ports(sequencer, os.getenv('ALSA_OUTPUT_PORTS'))
+        if len(ports) < 1:
+            fatal("Please specify at least one port with --port.")
+
+    if len(args) < 1:
+        fatal("Please specify a file to play.")
+
+    source_port = create_source_port(sequencer)
+    queue = create_queue(sequencer)
+    connect_ports(sequencer, source_port, ports)
+
+    for filename in args:
+        play(sequencer, filename, end_delay, source_port, queue, ports)
+
+
+if __name__ == '__main__':
+    main()
diff -r 02b11d9f243d test/aseqdump.py
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/aseqdump.py	Thu Jan 24 05:18:40 2008 -0300
@@ -0,0 +1,193 @@
+#! /usr/bin/python
+
+# aseqdump.py -- python port of aplaymidi
+# Copyright (C) 2008 Aldrin Martoq <amartoq@dcc.uchile.cl>
+#
+# Based on code from aseqdump.c, from ALSA project
+# Copyright (C) 2005 Clemens Ladisch <clemens@ladisch.de>
+#
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+
+
+import sys
+sys.path.insert(0, '../pyalsa')
+
+import getopt
+import os
+import struct
+import alsaseq
+import traceback
+import time
+from alsaseq import *
+
+def errormsg(msg, *args):
+    """ prints an error message to stderr """
+    sys.stderr.write(msg % args)
+    sys.stderr.write('\n')
+    traceback.print_exc(file=sys.stderr)
+
+
+def fatal(msg, *args):
+    """ prints an error message to stderr, and dies """
+    errormsg(msg, *args)
+    sys.exit(1)
+
+
+def init_seq():
+    """ opens an alsa sequencer """
+    try:
+        sequencer = Sequencer(name = 'default',
+                              clientname = 'aseqdump.py',
+                              streams = SEQ_OPEN_DUPLEX,
+                              mode = SEQ_BLOCK)
+        return sequencer
+    except SequencerError, e:
+        fatal("open sequencer: %e", e)
+
+
+def parse_ports(sequencer, portspec):
+    """ parses one or more port addresses from the string, separated by ','
+    example: 14:0,Timidity
+    """
+    portlist = []
+    if portspec == None:
+        return portlist
+    ports = portspec.split(',')
+    for port in ports:
+        try:
+            client, port = sequencer.parse_address(port)
+            portlist.append((client, port))
+        except SequencerError, e:
+            fatal("Failed to parse port %s - %s", port, e)
+    return portlist
+
+
+def create_source_port(sequencer):
+    try :
+        port = sequencer.create_simple_port(name = 'aseqdump.py',
+                                            type = SEQ_PORT_TYPE_MIDI_GENERIC
+                                            | SEQ_PORT_TYPE_APPLICATION,
+                                            caps = SEQ_PORT_CAP_WRITE
+                                            | SEQ_PORT_CAP_SUBS_WRITE)
+        return port
+    except SequencerError, e:
+        fatal("Failed to create port - %s", e)
+
+
+def connect_ports(sequencer, port_id, ports):
+    client_id = sequencer.client_id
+    for client, port in ports:
+        sequencer.connect_ports((client, port),(client_id, port_id))
+
+def dump_event(event):
+    print "%3d:%-3d" % ((event.source)[0], (event.source)[1]),
+    type = event.type
+    data = event.get_data()
+    if type == SEQ_EVENT_NOTEON:
+        print "Note on                %2d %3d %3d" % \
+            (data['note.channel'], data['note.note'], data['note.velocity'])
+    elif type == SEQ_EVENT_NOTEOFF:
+        print "Note off               %2d %3d %3d" % \
+            (data['note.channel'], data['note.note'], data['note.velocity'])
+    elif type == SEQ_EVENT_KEYPRESS:
+        print "Polyphonic aftertouch  %2d %3d %3d" % \
+            (data['note.channel'], data['note.note'], data['note.velocity'])
+    elif type == SEQ_EVENT_CONTROLLER:
+        print "Control change         %2d %3d %3d" % \
+            (data['control.channel'], data['control.param'],
data['control.value'])
+    elif type == SEQ_EVENT_PGMCHANGE:
+        print "Program change         %2d %3d" % \
+            (data['control.channel'], data['control.value'])
+    else:
+        print "Event type %d" % type
+
+def list_ports():
+    sequencer = init_seq()
+    print " Port    Client name                      Port name";
+    clientports = sequencer.connection_list()
+    for connections in clientports:
+        clientname, clientid, connectedports = connections
+        for port in connectedports:
+            portname, portid, connections = port
+            portinfo = sequencer.get_port_info(portid, clientid)
+            caps = portinfo['capability']
+            if caps & (SEQ_PORT_CAP_READ | SEQ_PORT_CAP_SUBS_READ):
+                print "%3d:%-3d  %-32.32s %s" % (clientid, portid,
clientname, portname)
+
+def usage():
+    print "Usage: %s [options]\n" \
+        "\nAvailable options:\n" \
+        "-h, --help                  this help\n" \
+        "-V, --version               show version\n" \
+        "-l, --list                  list input ports\n" \
+        "-p, --port=client:port,...  source port(s)\n" \
+        % (sys.argv[0])
+
+def version():
+    print "aseqdump.py asoundlib version %s" % (SEQ_LIB_VERSION_STR)
+
+
+def main():
+    sequencer = init_seq()
+    ports = []
+    end_delay = 2
+
+    try:
+        opts, args = getopt.getopt(sys.argv[1:], "hVlp:", ["help",
"version", "list", "port="])
+    except getopt.GetoptError:
+        usage()
+        sys.exit(2)
+    for o, a in opts:
+        if o in ("-h", "--help"):
+            usage()
+            sys.exit(0)
+        elif o in ("-V", "--version"):
+            version()
+            sys.exit(0)
+        elif o in ("-l", "--list"):
+            list_ports()
+            sys.exit(0)
+        elif o in ("-p", "--port"):
+            ports = parse_ports(sequencer, a)
+        elif o in ("-d", "--delay"):
+            end_delay = int(a)
+
+    source_port = create_source_port(sequencer)
+    connect_ports(sequencer, source_port, ports)
+
+    sequencer.mode = SEQ_NONBLOCK
+
+    if len(ports) > 0:
+        print "Waiting for data.",
+    else:
+        print "Waiting for data at port %d:0." % sequencer.client_id,
+
+    print "Press Ctrl+C to end."
+    print "Source_ Event_________________ Ch _Data__"
+
+    while True:
+        try:
+            eventlist = sequencer.receive_events(timeout=10069, maxevents = 1)
+            for event in eventlist:
+                dump_event(event)
+        except KeyboardInterrupt:
+            pass
+            break
+
+
+
+if __name__ == '__main__':
+    main()
diff -r 02b11d9f243d test/seqtest1.py
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/seqtest1.py	Thu Jan 24 05:18:40 2008 -0300
@@ -0,0 +1,189 @@
+#! /usr/bin/python
+# Sample code for pyalsa Sequencer binding
+# by Aldrin Martoq <amartoq@dcc.uchile.cl>
+# version 2008012401 (UTC: 1201153962 secs since the epoch)
+#
+# This code is in the public domain,
+# use it as base for creating your pyalsa
+# sequencer application.
+
+import sys
+sys.path.insert(0, '../pyalsa')
+del sys
+from alsamemdebug import debuginit, debug, debugdone
+import alsaseq
+
+
+def dump_portinfo(dict):
+    def dl(dict, key):
+        if dict.has_key(key):
+            return "'" + str(dict[key]) + "'"
+        return "N/A"
+    def da(dict, key, search):
+        tmp = None
+        if dict.has_key(key):
+            for k in search:
+                if k & dict[key]:
+                    if tmp == None:
+                        tmp = str(search[k])
+                    else:
+                        tmp += " " + str(search[k])
+            if tmp == None:
+                tmp = "UNKNOWN(%d)" % (dict[key])
+        else:
+            tmp = "N/A"
+        return tmp
+
+    return "name=%s capability=%s type=%s" % (dl(dict, 'name'),
da(dict, 'capability', alsaseq._dportcap), da(dict, 'type',
alsaseq._dporttype))
+
+def dump_list(connections, simple=True):
+    for clientports in connections:
+        clientname, clientid, portlist = clientports
+        print "    client: %3d    %s" % (clientid, clientname),
+        if not simple:
+            clientinfo = sequencer.get_client_info(clientid)
+            print "\t[%s]" % clientinfo
+        else:
+            print
+        for port in portlist:
+            portname, portid, connections = port
+            print "      port: %3d:%-2d +-%s" % (clientid, portid, portname),
+            if not simple:
+                portinfo = sequencer.get_port_info(portid, clientid)
+                print "\t[%s]" % (dump_portinfo(portinfo))
+            else:
+                print
+            readconn, writeconn = connections
+            for c,p,i in readconn:
+                if not simple:
+                    print "        connection   to: %d:%d %s" % (c,p, i)
+                else:
+                    print "        connection   to: %d:%d" % (c,p)
+            for c,p,i in writeconn:
+                if not simple:
+                    print "        connection   to: %d:%d %s" % (c,p, i)
+                else:
+                    print "        connection   to: %d:%d" % (c,p)
+
+
+debuginit()
+
+print "01:Creating Sequencer =============================="
+sequencer = alsaseq.Sequencer()
+# other examples:
+# sequencer = alsaseq.Sequencer("hw", "myfancyapplication",
alsaseq.SEQ_OPEN_INPUT, alsaseq.SEQ_BLOCK)
+# sequencer = alsaseq.Sequencer(clientname='python-test',
streams=alsaseq.SEQ_OPEN_OUTPUT)
+print "    sequencer:  %s" % sequencer
+print "    name:       %s" % sequencer.name
+print "    clientname: %s" % sequencer.clientname
+print "    streams:    %d (%s)" % (sequencer.streams, str(sequencer.streams))
+print "    mode:       %d (%s)" % (sequencer.mode, str(sequencer.mode))
+print "    client_id:  %s" % sequencer.client_id
+print
+
+print "02:Changing some parameters ========================"
+sequencer.clientname = 'pepito'
+sequencer.mode = alsaseq.SEQ_BLOCK
+print "    clientname: %s" % sequencer.clientname
+print "    mode:       %d (%s)" % (sequencer.mode, str(sequencer.mode))
+print
+
+print "03:Creating simple port ============================"
+port_id = sequencer.create_simple_port("myport",
alsaseq.SEQ_PORT_TYPE_APPLICATION,alsaseq.SEQ_PORT_CAP_WRITE |
alsaseq.SEQ_PORT_CAP_SUBS_WRITE)
+print "    port_id:    %s" % port_id
+print
+
+print "04:Getting port info ==============================="
+port_info = sequencer.get_port_info(port_id)
+print "      -->       %s" % dump_portinfo(port_info)
+print "      -->       %s" % port_info
+print
+
+print "05:Retrieving clients and connections (as list) ===="
+connections = sequencer.connection_list()
+print "  %s" % (connections)
+print
+
+print "06:Retrieving clients and connections (detailed) ==="
+connections = sequencer.connection_list()
+dump_list(connections, False)
+print
+
+print "07:Connecting 'arbitrary' ports... ================="
+source = (alsaseq.SEQ_CLIENT_SYSTEM, alsaseq.SEQ_PORT_SYSTEM_ANNOUNCE)
+dest = (sequencer.client_id, port_id)
+print "%s ---> %s" % (str(source), str(dest))
+sequencer.connect_ports(source, dest)
+print
+
+print "08:Retrieving clients and connections (simple) ====="
+connections = sequencer.connection_list()
+dump_list(connections)
+print
+
+print "09:Disconnecting previous 'arbitrary' port ========="
+print "%s -X-> %s" % (str(source), str(dest))
+sequencer.disconnect_ports(source, dest)
+print
+
+print "10:Retrieving clients and connections (simple) ====="
+connections = sequencer.connection_list()
+dump_list(connections)
+print
+
+print "11:Listing known streams constants ================="
+print "%s" % alsaseq._dstreams.values()
+print
+
+print "12:Listing known mode constants ===================="
+print "%s" % alsaseq._dmode.values()
+print
+
+print "13:Listing known queue constants ==================="
+print "%s" % alsaseq._dqueue.values()
+print
+
+print "14:Listing known client type constants ============="
+print "%s" % alsaseq._dclienttype.values()
+print
+
+print "15:Listing known port caps constants ==============="
+print "%s" % alsaseq._dportcap.values()
+print
+
+print "16:Listing known port types constants =============="
+print "%s" % alsaseq._dporttype.values()
+print
+
+print "17:Listing known event type constants =============="
+print "%s" % alsaseq._deventtype.values()
+print
+
+print "18:Listing known event timestamp constants ========="
+print "%s" % alsaseq._deventtimestamp.values()
+print
+
+print "19:Listing known event timemode constants =========="
+print "%s" % alsaseq._deventtimemode.values()
+print
+
+print "20:Listing known client addresses constants ========"
+print "%s" % alsaseq._dclient.values()
+print
+
+print "21:Listing known port addresses constants =========="
+print "%s" % alsaseq._dport.values()
+print
+
+
+print "98:Removing sequencer =============================="
+debug([sequencer])
+del sequencer
+print
+
+print "99:Listing sequencer (using new one) ==============="
+dump_list(alsaseq.Sequencer().connection_list())
+print
+
+debugdone()
+print "seqtest1.py done."
diff -r 02b11d9f243d test/seqtest2.py
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/seqtest2.py	Thu Jan 24 05:18:40 2008 -0300
@@ -0,0 +1,62 @@
+#! /usr/bin/python
+# Sample code for pyalsa Sequencer binding
+# by Aldrin Martoq <amartoq@dcc.uchile.cl>
+# version 2008012401 (UTC: 1201153962 secs since the epoch)
+#
+# This code is in the public domain,
+# use it as base for creating your pyalsa
+# sequencer application.
+
+import sys
+sys.path.insert(0, '../pyalsa')
+
+import alsaseq
+import time
+from alsamemdebug import debuginit, debug, debugdone
+
+debuginit()
+
+seq = alsaseq.Sequencer()
+
+def dump(event):
+    print "event: %s" % event
+    print "  ",
+    for attr in alsaseq.SeqEvent.__dict__:
+        if attr.startswith('is_'):
+            t = event.__getattribute__(attr)
+            if t:
+                print "%s" % attr,
+    print
+    data = event.get_data()
+    print "  data=%s" % data
+
+print "sequencer: %s" % seq
+
+port_id = seq.create_simple_port('hola', alsaseq.SEQ_PORT_TYPE_APPLICATION,
+                                 alsaseq.SEQ_PORT_CAP_SUBS_READ |
alsaseq.SEQ_PORT_CAP_READ | alsaseq.SEQ_PORT_CAP_WRITE |
alsaseq.SEQ_PORT_CAP_SUBS_WRITE
+                                 )
+
+print "portid: %d" % port_id
+
+c=-2
+wait = 5000
+
+while True:
+    if c == -1:
+        src = (alsaseq.SEQ_CLIENT_SYSTEM,alsaseq.SEQ_PORT_SYSTEM_ANNOUNCE)
+        dest = (seq.client_id, port_id)
+        print 'connecting %s -> %s' % (src, dest)
+        seq.connect_ports(src, dest)
+    if c == 5:
+        break
+    print 'waiting %s...' % wait
+    events = seq.receive_events(wait)
+    for event in events:
+        c = 0
+        dump(event)
+        del event
+    c += 1
+
+debug([seq])
+
+debugdone()
diff -r 02b11d9f243d test/seqtest3.py
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/seqtest3.py	Thu Jan 24 05:18:40 2008 -0300
@@ -0,0 +1,71 @@
+#! /usr/bin/python
+# Sample code for pyalsa Sequencer binding
+# by Aldrin Martoq <amartoq@dcc.uchile.cl>
+# version 2008012401 (UTC: 1201153962 secs since the epoch)
+#
+# This code is in the public domain,
+# use it as base for creating your pyalsa
+# sequencer application.
+
+import sys
+sys.path.insert(0, '../pyalsa')
+
+from alsaseq import *
+import time
+from alsamemdebug import debuginit, debug, debugdone
+
+debuginit()
+
+def findmidiport():
+    for connections in seq.connection_list():
+        cname, cid, ports = connections
+        # skip midi through
+        if cname == 'Midi Through':
+            continue
+        for port in ports:
+            pname, pid, pconns = port
+            pinfo = seq.get_port_info(pid, cid)
+            type = pinfo['type']
+            caps = pinfo['capability']
+            if type & SEQ_PORT_TYPE_MIDI_GENERIC and caps &
(SEQ_PORT_CAP_WRITE):
+                print "Using port: %s:%s" % (cname, pname)
+                return (cid, pid)
+    print "No midi port found -- install timidity or other software
synth for testing!"
+    sys.exit(0)
+
+# create sequencer
+seq = Sequencer()
+
+# find midi port
+cid, pid = findmidiport()
+
+# create a queue
+queue = seq.create_queue()
+seq.start_queue(queue)
+tempo, ppq = seq.queue_tempo(queue)
+print "tempo: %d ppq: %d" % (tempo, ppq)
+
+# play notes: DO RE MI FA SOL LA
+notes = [0x40, 0x42, 0x44, 0x45, 0x47, 0x49]
+event = SeqEvent(SEQ_EVENT_NOTE)
+for note in notes:
+    event.dest = (cid, pid)
+    event.queue = queue
+    event.time += ppq
+    event.set_data({'note.note' : note, 'note.velocity' : 64,
'note.duration' : ppq , 'note.off_velocity' : 64})
+    print 'event: %s %s' % (event, event.get_data())
+    seq.output_event(event)
+    seq.drain_output()
+    seq.sync_output_queue()
+
+# stop queue and delete queue
+seq.stop_queue(queue)
+seq.delete_queue(queue)
+
+debug([seq])
+
+# close sequencer
+del seq
+
+
+debugdone()



-- 
Aldrin Martoq
