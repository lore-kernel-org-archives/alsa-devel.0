From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: [PATCH] pyalsa sequencer binding - 1/3
Date: Tue, 8 Jan 2008 14:40:00 -0300
Message-ID: <17eedd8a0801080940i14edaef0l2f95e0eb6171cdaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by alsa0.perex.cz (Postfix) with ESMTP id D4161248E5
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 18:40:02 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so3298518wxc.23
	for <alsa-devel@alsa-project.org>; Tue, 08 Jan 2008 09:40:01 -0800 (PST)
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

Hi hackers,

The patch below is the first of a series for implementing the pyalsa
(python alsa) binding for the sequencer API of libasound2 that I hope
be included in alsa.
The following features are implemented:

1.- Opening a sequencer
1.1 support for SEQ_OPEN_{INPUT,OUTPUT,DUPLEX}
1.2 support for SEQ_NONBLOCK or blocking mode (SEQ_BLOCK)
1.3 support for alsa hw name and clientname
2.- Creating a simple port
2.1 support for port name
2.2 support for port capabilities bits SEQ_PORT_CAP_*
2.3 support for port types bits SEQ_PORT_TYPE_*
3.- Listing all connected client and their ports
3.1 client id's and names
3.2 port lists
3.3 read/write connections of ports
4.- Getting port info by clientid, portid
4.1 name of port
4.2 port capabilities
4.3 port type

I *encourage to test and stress* the current implementation, which is
a rewrite of what I wrote for the old pyalsaaudio project. The
features presented are sufficient for creating a simple (or
graphically!) aconnect python port, there is a sample 'seqtest1.py'
using all the features.


Planned features for next release:
1. alsaseq.SequencerError -- base exception for all exceptions (right
now all method raises RuntimeError)
2. alsaseq.SequenceEvent -- for receiving and sending events
3. Fixing missing documentation (marked as TODO in alsaseq.c)

Thank you for all your hard and good work.
-----
Signed-off-by: Aldrin Martoq <amartoq@dcc.uchile.cl>

diff -r 5080500e6cd3 pyalsa/alsaseq.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pyalsa/alsaseq.c	Tue Jan 08 14:32:01 2008 -0300
@@ -0,0 +1,846 @@
+/*
+ *  Python binding for the ALSA library - sequencer
+ *  Copyright (c) 2007 by Aldrin Martoq <amartoq@dcc.uchile.cl>
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
+/////////////////////////////////////////////////////////////////////
+// some helper #define go here...
+/////////////////////////////////////////////////////////////////////
+
+/* temporal debug (will be deleted in last patch, promise!) */
+#define ddebug(x, args...) fprintf(stderr, x "\n",##args);
+
+/* check passed object is integer and can't be deleted */
+#define SETCHECKPYINT(attr, val) \
+	if (val == NULL) { \
+		PyErr_SetString(PyExc_AttributeError, "attribute " attr " can't be
deleted!"); \
+		return -1; \
+	} \
+	if (!PyInt_Check(val)) { \
+		PyErr_SetString(PyExc_TypeError, "int value expected for " attr); \
+		return -1; \
+	}
+
+/* check if alsaseq.SEQ* constants is being used */
+/*
+ #define CHECKCONSTANT(attr, obj, type) \
+	if (!PyObject_TypeCheck(obj, type)) { \
+		PyErr_Warn(PyExc_RuntimeWarning, "please use only constants from
alsaseq.SEQ*"); \
+	}
+ */
+#define CHECKCONSTANT(attr, obj, type)
+
+/* check passed object is string and can't be deleted */
+#define SETCHECKPYSTR(attr, val) \
+	if (val == NULL) { \
+		PyErr_SetString(PyExc_AttributeError, "attribute " attr " can't be
deleted!"); \
+		return -1; \
+	} \
+	if (!PyString_Check(val)) { \
+		PyErr_SetString(PyExc_TypeError, "string value expected for " attr); \
+		return -1; \
+	}
+
+/* free only if pointer is not NULL */
+#define FREECHECKED(name, pointer) \
+	if (pointer != NULL) { \
+		free(pointer); \
+		pointer = NULL; \
+	}
+
+/* add constant as integer to module */
+#define CONST(module, name, value) \
+	if (PyModule_AddIntConstant(module, name, (long) value) < 0) { \
+		return; \
+	}
+
+/* define constant dict by type */
+#define TDICT(subtype, name) \
+	PyObject *_dictPYALSASEQ_CONST_##subtype = tmp = PyDict_New(); \
+	if (PyModule_AddObject(module, name, tmp) < 0) { \
+		return; \
+	} \
+
+/* create typed constant and add to module */
+#define TCONST(module, subtype, name, value) \
+	tmp = Constant_create(name, value, PYALSASEQ_CONST_##subtype); \
+	if (PyModule_AddObject(module, name, tmp) < 0) { \
+		return; \
+	} \
+	PyDict_SetItem(_dictPYALSASEQ_CONST_##subtype, PyInt_FromLong(value), tmp);
+
+/* num protocol support for binary Constant operations */
+#define NUMPROTOCOL2(name, oper) \
+static PyObject *Constant_##name (PyObject *v, PyObject *w) { \
+	int type = 0; \
+	long val = 0; \
+	/* both have to be a int */ \
+	if (!PyInt_Check(v) || !PyInt_Check(w)) { \
+		Py_INCREF(Py_NotImplemented);   \
+		return Py_NotImplemented;       \
+	} \
+	val = PyInt_AS_LONG(v) oper PyInt_AS_LONG(w); \
+	/* always asume left will be the type */ \
+	if (PyObject_TypeCheck(v, &ConstantType)) { \
+		type = ((ConstantObject *) v)->type; \
+	} else if (PyObject_TypeCheck(w, &ConstantType)) { \
+		type = ((ConstantObject *) w)->type; \
+	} \
+	PyObject *self = Constant_create(#oper, val, type); \
+	return self; \
+}
+/* num protocol support for unary Constant operations */
+#define NUMPROTOCOL1(name, oper) \
+static PyObject *Constant_##name (PyObject *v) { \
+	int type = 0; \
+	long val = 0; \
+	if (!PyInt_Check(v)) { \
+		Py_INCREF(Py_NotImplemented);   \
+		return Py_NotImplemented;       \
+	} \
+	val = oper PyInt_AS_LONG(v); \
+	if (PyObject_TypeCheck(v, &ConstantType)) { \
+		type = ((ConstantObject *) v)->type; \
+	} \
+	PyObject *self = Constant_create(#oper, val, type); \
+	return self; \
+}
+
+//#define ddebug(x) {}
+
+// alsaseq.Constant type definitions
+enum {
+	PYALSASEQ_CONST_STREAMS,
+	PYALSASEQ_CONST_MODE,
+	PYALSASEQ_CONST_PORT_CAP,
+	PYALSASEQ_CONST_PORT_TYPE
+};
+
+/////////////////////////////////////////////////////////////////////
+// alsaseq.Constant implementation
+/////////////////////////////////////////////////////////////////////
+
+/** alsaseq.Constant __doc__ */
+// TODO: write doc
+PyDoc_STRVAR(Constant__doc__,
+		"Constant type: TODO: write doc"
+);
+
+/** alsaseq.Constant object structure type */
+typedef struct {
+	PyObject_HEAD
+	;
+
+	/* value of constant */
+	long value;
+	/* name of constant */
+	const char *name;
+	/* type of constant */
+	int type;
+} ConstantObject;
+
+/** alsaseq.Constant type (initialized later...) */
+static PyTypeObject ConstantType;
+
+/** alsaseq.Constant internal create */
+static PyObject *Constant_create(const char *name, long value, int type) {
+	ConstantObject *self= PyObject_New(ConstantObject, &ConstantType);
+	if (self == NULL) {
+		return NULL;
+	}
+
+	self->value = value;
+	self->name = name;
+	self->type = type;
+
+	return (PyObject *)self;
+}
+
+/** alsaseq.Constant tp_repr */
+static PyObject *Constant_repr(ConstantObject *self) {
+	return PyString_FromFormat("<alsaseq.Constant %s (%ld)", self->name,
+	                self->value);
+}
+
+/** alsaseq.Constant tp_str */
+static PyObject *Constant_str(ConstantObject *self) {
+	return PyString_FromFormat("%s", self->name);
+}
+
+/** alsaseq.Constant Number protocol support (note: not all operations) */
+NUMPROTOCOL2(Add, +)
+NUMPROTOCOL2(Subtract, -)
+NUMPROTOCOL2(Xor, ^)
+NUMPROTOCOL2(Or, |)
+NUMPROTOCOL2(And, &)
+NUMPROTOCOL1(Invert, ~)
+
+static PyNumberMethods Constant_as_number = { nb_add:
(binaryfunc)Constant_Add, nb_subtract: (binaryfunc)Constant_Subtract,
nb_xor: (binaryfunc)Constant_Xor, nb_or: (binaryfunc)Constant_Or,
nb_and: (binaryfunc)Constant_And, nb_invert:
(unaryfunc)Constant_Invert };
+
+/** alsaseq.Constant type */
+static PyTypeObject ConstantType = { PyObject_HEAD_INIT(NULL)
+tp_name: "alsaseq.Constant",
+tp_base: &PyInt_Type,
+tp_basicsize: sizeof(ConstantObject),
+tp_flags: Py_TPFLAGS_HAVE_GETCHARBUFFER | Py_TPFLAGS_HAVE_CLASS |
Py_TPFLAGS_CHECKTYPES,
+tp_doc: Constant__doc__,
+//tp_dealloc: (destructor)PyObject_Del,
+tp_as_number: &Constant_as_number,
+tp_free: PyObject_Del, tp_str: (reprfunc)Constant_str,
+tp_repr: (reprfunc)Constant_repr, };
+
+/////////////////////////////////////////////////////////////////////
+// alsaseq.Sequencer implementation
+/////////////////////////////////////////////////////////////////////
+
+/** alsaseq.Sequencer __doc__ */
+// TODO: write doc
+PyDoc_STRVAR(Sequencer__doc__,
+		"Sequencer class: TODO: write doc"
+);
+
+/** alsaseq.Sequencer object structure type */
+typedef struct {
+	PyObject_HEAD
+	;
+
+	/* name of device */
+	char *name;
+	/* name of client */
+	char *clientname;
+	/* client id */
+	int client_id;
+	/* streams */
+	int streams;
+	/* mode */
+	int mode;
+
+	/* alsa handler */
+	snd_seq_t *handle;
+	/* max fd's */
+	int receive_max;
+	/* receive poll fd's */
+	struct pollfd *receive_fds;
+	/* max events for returning in receive_events() */
+	int receive_max_events;
+} SequencerObject;
+
+/** alsaseq.Sequencer type (initialized later...) */
+static PyTypeObject SequencerType;
+
+/** alsaseq.Sequencer tp_init */
+static int Sequencer_init(SequencerObject *self, PyObject *args,
PyObject *kwds) {
+	int ret;
+	/* defaults */
+	char *name = "default";
+	char *clientname = "pyalsa";
+	self->streams = SND_SEQ_OPEN_DUPLEX;
+	self->mode = SND_SEQ_NONBLOCK;
+	int maxreceiveevents = 10;
+
+	char *kwlist[] = { "name", "clientname", "streams", "mode",
+	                "maxreceiveevents", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwds, "|ssiii", kwlist, &name,
+	                &clientname, &self->streams, &self->mode,
+	                &maxreceiveevents)) {
+		return -1;
+	}
+
+	self->name = strdup(name);
+	self->clientname = strdup(clientname);
+	self->receive_fds = NULL;
+	self->receive_max = 0;
+	self->receive_max_events
+	                = (self->mode == SND_SEQ_NONBLOCK ? maxreceiveevents
+	                                : 0);
+
+	ret = snd_seq_open(&(self->handle), self->name, self->streams,
+	                self->mode);
+	if (ret < 0) {
+		// TODO: raise exception
+		return -1;
+	}
+	ret = snd_seq_set_client_name(self->handle, self->clientname);
+	if (ret < 0) {
+		// TODO: raise exception
+		return -1;
+	}
+	self->client_id = snd_seq_client_id(self->handle);
+
+	return 0;
+}
+
+/** alsaseq.Sequencer tp_dealloc */
+static void Sequencer_dealloc(SequencerObject *self) {
+	FREECHECKED("name", self->name)
+	FREECHECKED("clientname", self->clientname)
+	FREECHECKED("receive_fds", self->receive_fds)
+
+	if (self->handle) {
+		snd_seq_close(self->handle);
+		self->handle = NULL;
+	}
+
+	self->ob_type->tp_free(self);
+}
+
+/** alsaseq.Sequencer name attribute: __doc__ */
+PyDoc_STRVAR(Sequencer_name__doc__ ,
+		"name -- (string) the hardware name of this alsaseq.Sequencer
(default: \"default\"). "
+		"Note: read-only attribute.");
+
+/**
+ * alsaseq.Sequencer name attribute: tp_get getter()
+ *
+ * @param self -- the SeqEventObject
+ * @returns the alsa hardware name of this Sequencer.
+ */
+static PyObject *Sequencer_get_name(SequencerObject *self) {
+	return PyString_FromString(self->name);
+}
+
+/** alsaseq.Sequencer clientname attribute: __doc__ */
+PyDoc_STRVAR(Sequencer_clientname__doc__ ,
+		"clientname -- (string) the client name of this alsaseq.Sequencer
(default: \"pyalsa\").");
+
+/**
+ * alsaseq.Sequencer clientname attribute: tp_get getter()
+ *
+ * @param self -- the SeqEventObject
+ * @returns the client name of this Sequencer.
+ */
+static PyObject *Sequencer_get_clientname(SequencerObject *self) {
+	return PyString_FromString(self->clientname);
+}
+
+/**
+ * alsaseq.Sequencer clientname attribute: tp_get setter()
+ *
+ * @param self -- the SeqEventObject
+ * @param val  -- the new value to set (must be a string)
+ * @returns 0 on success, -1 on error
+ * @raises TypeError -- if the val parameter is not a String
+ */
+static int Sequencer_set_clientname(SequencerObject *self, PyObject *val) {
+	int ret;
+	char *buff;
+
+	SETCHECKPYSTR("clientname", val)
+
+	buff = PyString_AsString(val);
+
+	ret = snd_seq_set_client_name(self->handle, buff);
+	if (ret == 0) {
+		FREECHECKED("clientname", self->clientname)
+		self->clientname = strdup(buff);
+	} else {
+		// TODO: raise exception
+		return -1;
+	}
+	return 0;
+}
+
+/** alsaseq.Sequencer streams attribute: __doc__ */
+PyDoc_STRVAR(Sequencer_streams__doc__ ,
+		"streams -- (int) the streams of this alsaseq.Sequencer (default:
alsaseq.SEQ_OPEN_DUPLEX). "
+		"Posible values: alsaseq.SEQ_OPEN_OUTPUT, alsaseq.SEQ_OPEN_INPUT,
alsaseq.SEQ_OPEN_DUPLEX. "
+		"Note: read-only attribute.");
+
+/**
+ * alsaseq.Sequencer streams attribute: tp_get getter()
+ *
+ * @param self -- the SeqEventObject
+ * @returns the stremas of this Sequencer.
+ */
+static PyObject *Sequencer_get_streams(SequencerObject *self) {
+	return PyInt_FromLong(self->streams);
+}
+
+/** alsaseq.Sequencer mode attribute: __doc__ */
+PyDoc_STRVAR(Sequencer_mode__doc__ ,
+		"mode -- (int) the blocking mode of this alsaseq.Sequencer
(default: alsaseq.SEQ_NONBLOCK). "
+		"Posible values: alsaseq.SEQ_BLOCK, alsaseq.SEQ_NONBLOCK. ");
+
+/**
+ * alsaseq.Sequencer mode attribute: tp_get getter()
+ *
+ * @param self -- the SeqEventObject
+ * @returns the blocking mode of this Sequencer.
+ */
+static PyObject *Sequencer_get_mode(SequencerObject *self) {
+	return PyInt_FromLong(self->mode);
+}
+
+/**
+ * alsaseq.Sequencer mode attribute: tp_get setter()
+ *
+ * @param self -- the SeqEventObject
+ * @param val  -- the new value to set (must be a integer)
+ * @returns 0 on success, -1 on error
+ * @raises TypeError -- if the val parameter is not a integer
+ * @raises ValueError -- if the val parameter is not 0 (SEQ_BLOCK) or
1 (SEQ_NONBLOCK).
+ */
+static int Sequencer_set_mode(SequencerObject *self, PyObject *val) {
+	int ret, mode;
+
+	SETCHECKPYINT("mode", val)
+
+CHECKCONSTANT("mode", val, &ConstantType)
+
+										mode = (int) PyInt_AsLong(val);
+
+	if (mode != 0 && mode != SND_SEQ_NONBLOCK) {
+		PyErr_SetString(PyExc_ValueError, "Invalid value for mode.");
+		return -1;
+	}
+
+	ret = snd_seq_nonblock(self->handle, mode);
+	if (ret == 0) {
+		self->mode = mode;
+	} else {
+		// TODO: raise exception
+		return -1;
+	}
+	return 0;
+}
+
+/** alsaseq.Sequencer client_id attribute: __doc__ */
+PyDoc_STRVAR(Sequencer_client_id__doc__ ,
+		"client_id -- (int) the client id of this alsaseq.Sequencer. "
+		"Note: read-only attribute.");
+
+/**
+ * alsaseq.Sequencer client_id attribute: tp_get getter()
+ *
+ * @param self -- the SeqEventObject
+ * @returns the client id of this Sequencer.
+ */
+static PyObject *Sequencer_get_client_id(SequencerObject *self) {
+	return PyInt_FromLong(self->client_id);
+}
+
+/** alsaseq.Sequencer tp_getset list*/
+static PyGetSetDef Sequencer_getset[] = { { "name", (getter)Sequencer_get_name,
+                NULL, Sequencer_name__doc__, NULL }, { "clientname",
+                (getter)Sequencer_get_clientname,
+                (setter)Sequencer_set_clientname, Sequencer_clientname__doc__,
+                NULL }, { "streams", (getter) Sequencer_get_streams, NULL,
+                Sequencer_streams__doc__, NULL }, { "mode",
+                (getter) Sequencer_get_mode, (setter) Sequencer_set_mode,
+                Sequencer_mode__doc__, NULL }, { "client_id",
+                (getter) Sequencer_get_client_id, NULL,
+                Sequencer_client_id__doc__, NULL }, { NULL } };
+
+/** alsaseq.Sequencer tp_repr */
+static PyObject *Sequencer_repr(SequencerObject *self) {
+	return PyString_FromFormat(
+	                "<alsaseq.Sequencer client_id=%d name=%s
clientname=%s streams=%d mode=%d at 0x%p>",
+	                self->client_id, self->name, self->clientname,
+	                self->streams, self->mode, self);
+}
+
+/** alsaseq.Sequencer create_simple_port(): __doc__ */
+PyDoc_STRVAR(Sequencer_create_simple_port__doc__,
+		"create_simple_port(name, caps, type) -- Creates a port for
receiving or sending events.\n\n"
+		"Parameters:\n"
+		"    name -- (string) name of the port\n"
+		"    caps -- (int) capabilites of the port (use bitwise
alsaseq.SEQ_PORT_CAP_* constants)\n"
+		"    type -- (int) type of port (use one of the
alsaseq.SEQ_PORT_TYPE_* constants)"
+		"Returns:\n"
+		"  (int) the port id.\n"
+		"Raises:\n"
+		"  TypeError: an invalid type was used in a parameter\n"
+		"  ValueError: an invalid value was used in a parameter\n"
+);
+
+/**
+ * alsaseq.Sequencer create_simple_port()
+ */
+static PyObject *Sequencer_create_simple_port(SequencerObject *self,
+                                              PyObject *args) {
+	char *name;
+	unsigned int caps;
+	unsigned int type;
+	int port;
+
+	if (!PyArg_ParseTuple(args, "sII", &name, &caps, &type)) {
+		return NULL;
+	}
+	port = snd_seq_create_simple_port(self->handle, name, caps, type);
+	if (port < 0) {
+		// TODO: Throw exception
+		return NULL;
+	}
+
+	return PyInt_FromLong(port);
+}
+
+/** alsaseq.Sequencer get_client_ports(): __doc__ */
+PyDoc_STRVAR(Sequencer_get_client_ports__doc__,
+		"get_client_ports() -- List current clients and their ports
connected to alsa.\n\n"
+		"Returns:\n"
+		"  (list) a list of tuples: client_name, client_id, port_list.\n"
+		"    client_name -- the client's name\n"
+		"    client_id -- the client's id\n"
+		"    port_list -- a list of tuples: port_name, port_id, connection_list\n"
+		"      port_name -- the name of the port\n"
+		"      port_id -- the port id\n"
+		"      connection_list -- a list of tuples: read_conn, write_conn\n"
+		"        read_conn -- a list of tuples with the client_id, port_id
this port is connected to (sends events)\n"
+		"        write_conn -- a list of tuples with the client_id, port_id
this port is connected from (receives events)\n"
+);
+
+static PyObject *_query_connections_list(snd_seq_t *handle,
+                                         snd_seq_query_subscribe_t *query,
+                                         int type) {
+
+	PyObject *list = PyList_New(0);
+	int index = 0;
+	snd_seq_query_subscribe_set_type(query, type);
+	snd_seq_query_subscribe_set_index(query, index);
+	while (snd_seq_query_port_subscribers(handle, query) >= 0) {
+		const snd_seq_addr_t *addr =
+		                snd_seq_query_subscribe_get_addr(query);
+
+		/* create tuple for clientid, portid */
+		PyObject *tuple= PyTuple_New(2);
+		PyTuple_SetItem(tuple, 0, PyInt_FromLong(addr->client));
+		PyTuple_SetItem(tuple, 1, PyInt_FromLong(addr->port));
+
+		PyList_Append(list, tuple);
+		snd_seq_query_subscribe_set_index(query, ++index);
+	}
+	return list;
+}
+
+static PyObject *_query_connections(snd_seq_t *handle,
+                                    const snd_seq_addr_t *addr) {
+	snd_seq_query_subscribe_t *query;
+	snd_seq_query_subscribe_alloca(&query);
+	snd_seq_query_subscribe_set_root(query, addr);
+
+	/* create tuple for read,write lists */
+	PyObject *tuple = PyTuple_New(2);
+	PyObject *readlist = _query_connections_list(handle, query,
+	                SND_SEQ_QUERY_SUBS_READ);
+	PyObject *writelist = _query_connections_list(handle, query,
+	                SND_SEQ_QUERY_SUBS_WRITE);
+	PyTuple_SetItem(tuple, 0, readlist);
+	PyTuple_SetItem(tuple, 1, writelist);
+
+	return tuple;
+}
+
+/**
+ * alsaseq.Sequencer get_client_ports()
+ */
+static PyObject *Sequencer_get_client_ports(SequencerObject *self,
+                                            PyObject *args) {
+	snd_seq_client_info_t *cinfo;
+	snd_seq_port_info_t *pinfo;
+	PyObject *list = PyList_New(0);
+
+	if (list == NULL) {
+		return NULL;
+	}
+
+	snd_seq_client_info_alloca(&cinfo);
+	snd_seq_port_info_alloca(&pinfo);
+	snd_seq_client_info_set_client(cinfo, -1);
+	while (snd_seq_query_next_client(self->handle, cinfo) >= 0) {
+		/* reset query info */
+		snd_seq_port_info_set_client(pinfo,
+		                snd_seq_client_info_get_client(cinfo));
+		snd_seq_port_info_set_port(pinfo, -1);
+
+		/* create tuple for client info */
+		PyObject *tuple= PyTuple_New(3);
+		PyObject *portlist = PyList_New(0);
+
+		PyTuple_SetItem(tuple, 0, PyString_FromFormat("%s",
+		                snd_seq_client_info_get_name(cinfo)));
+		PyTuple_SetItem(
+		                tuple,
+		                1,
+		                PyInt_FromLong(snd_seq_client_info_get_client(cinfo)));
+
+		while (snd_seq_query_next_port(self->handle, pinfo) >= 0) {
+			/* create tuple for port info */
+			PyObject *porttuple = PyTuple_New(3);
+			PyTuple_SetItem(porttuple, 0, PyString_FromFormat("%s",
+			                snd_seq_port_info_get_name(pinfo)));
+			PyTuple_SetItem(
+			                porttuple,
+			                1,
+			                PyInt_FromLong(snd_seq_port_info_get_port(pinfo)));
+			/* create tuple for read,write connections */
+			PyObject *conntuple= _query_connections(self->handle,
+			                snd_seq_port_info_get_addr(pinfo));
+			PyTuple_SetItem(porttuple, 2, conntuple);
+			PyList_Append(portlist, porttuple);
+		}
+		PyTuple_SetItem(tuple, 2, portlist);
+
+		/* append list of port tuples */
+		PyList_Append(list, tuple);
+	}
+
+	return list;
+}
+
+/** alsaseq.Sequencer get_port_info(): __doc__ */
+PyDoc_STRVAR(Sequencer_get_port_info__doc__,
+		"get_port_info(port_id, client_id = self.client_id) -- Retrieve
info about an existing port of a client.\n\n"
+		"Parameters:\n"
+		"    port_id -- (int) the port id\n"
+		"    client_id -- (int) the client id (defaults to: self.client_id)\n"
+		"Returns:\n"
+		"  (dict) a dictionary with the following values:\n"
+		"    name -- (string) the port name\n"
+		"    type -- (int) the port type bit flags\n"
+		"    capability -- (int) the port capability bit flags\n"
+);
+
+/**
+ * alsaseq.Sequencer get_port_info()
+ */
+static PyObject *Sequencer_get_port_info(SequencerObject *self, PyObject *args,
+                                         PyObject *kwds) {
+	snd_seq_port_info_t *pinfo;
+	int port_id;
+	int client_id = self->client_id;
+	const char *tmpchar;
+	long tmplong;
+	int ret;
+
+	char *kwlist[] = { "port_id", "client_id", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwds, "i|i", kwlist, &port_id,
+	                &client_id)) {
+		return NULL;
+	}
+
+	PyObject *dict = PyDict_New();
+	if (dict == NULL) {
+		return NULL;
+	}
+
+	snd_seq_port_info_alloca(&pinfo);
+	/* query info */
+	ret
+	                = snd_seq_get_any_port_info(self->handle, client_id,
+	                                port_id, pinfo);
+	if (ret < 0) {
+		ddebug("FIXME: Throw exception: %s", snd_strerror(ret));
+		// TODO: Throw exception
+		return NULL;
+	}
+	tmpchar = snd_seq_port_info_get_name(pinfo);
+	PyDict_SetItem(dict, PyString_FromString("name"),
+	                PyString_FromString(tmpchar));
+
+	tmplong = snd_seq_port_info_get_capability(pinfo);
+	PyDict_SetItem(dict, PyString_FromString("capability"),
+	                PyInt_FromLong(tmplong));
+	tmplong = snd_seq_port_info_get_type(pinfo);
+	PyDict_SetItem(dict, PyString_FromString("type"),
+	                PyInt_FromLong(tmplong));
+
+	return dict;
+}
+
+/** alsaseq.Sequencer connect_ports(): __doc__ */
+PyDoc_STRVAR(Sequencer_connect_ports__doc__,
+		"connect_ports(srcaddr, dstaddr) -- Connect the ports specified by
srcaddr and dstaddr.\n\n"
+		"Parameters:\n"
+		"    srcaddr -- (tuple) the client_id, port_id tuple for the source
port (the port sending events)\n"
+		"    dstaddr -- (tuple) the client_id, port_id tuple for the
destination port (the port receiveng events)\n"
+);
+
+/**
+ * alsaseq.Sequencer connect_ports()
+ */
+static PyObject *Sequencer_connect_ports(SequencerObject *self,
PyObject *args) {
+        snd_seq_addr_t sender, dest;
+        snd_seq_port_subscribe_t *sinfo;
+        int ret;
+
+	if (!PyArg_ParseTuple(args, "(BB)(BB)",
+	                &(sender.client), &(sender.port), &(dest.client),
&(dest.port))) {
+		return NULL;
+	}
+
+        snd_seq_port_subscribe_alloca(&sinfo);
+        snd_seq_port_subscribe_set_sender(sinfo, &sender);
+        snd_seq_port_subscribe_set_dest(sinfo, &dest);
+
+	ret = snd_seq_subscribe_port(self->handle, sinfo);
+	if (ret < 0) {
+		ddebug("FIXME: Raise Exception: %s", snd_strerror(ret));
+		return NULL;
+	}
+
+	Py_INCREF(Py_None);
+
+	return Py_None;
+}
+
+/** alsaseq.Sequencer disconnect_ports(): __doc__ */
+PyDoc_STRVAR(Sequencer_disconnect_ports__doc__,
+		"disconnect_ports(srcaddr, dstaddr) -- Disconnect the ports
specified by srcaddr and dstaddr.\n\n"
+		"Parameters:\n"
+		"    srcaddr -- (tuple) the client_id, port_id tuple for the source
port (the port sending events)\n"
+		"    dstaddr -- (tuple) the client_id, port_id tuple for the
destination port (the port receiveng events)\n"
+);
+
+/**
+ * alsaseq.Sequencer disconnect_ports()
+ */
+static PyObject *Sequencer_disconnect_ports(SequencerObject *self,
PyObject *args) {
+        snd_seq_addr_t sender, dest;
+        snd_seq_port_subscribe_t *sinfo;
+        int ret;
+
+	if (!PyArg_ParseTuple(args, "(BB)(BB)",
+	                &(sender.client), &(sender.port), &(dest.client),
&(dest.port))) {
+		return NULL;
+	}
+
+        snd_seq_port_subscribe_alloca(&sinfo);
+        snd_seq_port_subscribe_set_sender(sinfo, &sender);
+        snd_seq_port_subscribe_set_dest(sinfo, &dest);
+
+	ret = snd_seq_unsubscribe_port(self->handle, sinfo);
+	if (ret < 0) {
+		ddebug("FIXME: Raise Exception: %s", snd_strerror(ret));
+		return NULL;
+	}
+
+	Py_INCREF(Py_None);
+
+	return Py_None;
+}
+
+/** alsaseq.Sequencer tp_methods */
+static PyMethodDef Sequencer_methods[] = { { "create_simple_port",
+                (PyCFunction) Sequencer_create_simple_port, METH_VARARGS,
+                Sequencer_create_simple_port__doc__ }, { "get_client_ports",
+                (PyCFunction) Sequencer_get_client_ports, METH_VARARGS,
+                Sequencer_get_client_ports__doc__ }, { "get_port_info",
+                (PyCFunction) Sequencer_get_port_info,
+                METH_VARARGS, Sequencer_get_port_info__doc__ },
+                {"connect_ports", (PyCFunction)
Sequencer_connect_ports, METH_VARARGS, Sequencer_connect_ports__doc__
},
+                {"disconnect_ports", (PyCFunction)
Sequencer_disconnect_ports, METH_VARARGS,
Sequencer_disconnect_ports__doc__ },
+                { NULL } };
+
+/** alsaseq.Sequencer type */
+static PyTypeObject SequencerType = { PyObject_HEAD_INIT(NULL)
+tp_name: "alsaseq.Sequencer",
+tp_basicsize: sizeof(SequencerObject),
+tp_dealloc: (destructor)Sequencer_dealloc,
+tp_flags: Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE,
+tp_doc: Sequencer__doc__,
+tp_init: (initproc)Sequencer_init,
+tp_new: PyType_GenericNew,
+tp_alloc: PyType_GenericAlloc,
+tp_free: PyObject_Del, tp_repr: (reprfunc)Sequencer_repr,
+tp_methods: Sequencer_methods, tp_getset: Sequencer_getset
+};
+
+/////////////////////////////////////////////////////////////////////
+// alsaseq module implementation
+/////////////////////////////////////////////////////////////////////
+
+/** alsaseq module: __doc__ */
+// TODO: write documentation
+PyDoc_STRVAR(alsaseq__doc__, "alsaseq: TODO: write documentation");
+
+/** alsaseq module methods */
+static PyMethodDef alsaseq_methods[] = { { NULL },
+};
+
+PyMODINIT_FUNC
+initalsaseq(void) {
+	PyObject *module;
+	PyObject *tmp;
+
+	if (PyType_Ready(&ConstantType) < 0) {
+		return;
+	}
+
+	if (PyType_Ready(&SequencerType) < 0) {
+		return;
+	}
+
+	module = Py_InitModule3("alsaseq", alsaseq_methods, alsaseq__doc__);
+
+	Py_INCREF(&SequencerType);
+	PyModule_AddObject(module, "Sequencer", (PyObject *) &SequencerType);
+	Py_INCREF(&ConstantType);
+	PyModule_AddObject(module, "Constant", (PyObject *) &ConstantType);
+
+	// constants definition
+
+	TDICT(STREAMS, "_const_streams");
+	TDICT(MODE, "_const_mode");
+	TDICT(PORT_CAP, "_const_port_cap");
+	TDICT(PORT_TYPE, "_const_port_type");
+
+	/* streams */
+
+	TCONST(module, STREAMS, "SEQ_OPEN_OUTPUT", SND_SEQ_OPEN_OUTPUT);
+	TCONST(module, STREAMS, "SEQ_OPEN_INPUT", SND_SEQ_OPEN_INPUT);
+	TCONST(module, STREAMS, "SEQ_OPEN_DUPLEX", SND_SEQ_OPEN_DUPLEX);
+
+	/* blocking mode */
+	TCONST(module, MODE, "SEQ_BLOCK", 0);
+	TCONST(module, MODE, "SEQ_NONBLOCK", SND_SEQ_NONBLOCK);
+
+	/* port cap */
+	TCONST(module, PORT_CAP, "SEQ_PORT_CAP_WRITE", SND_SEQ_PORT_CAP_WRITE);
+	TCONST(module, PORT_CAP, "SEQ_PORT_CAP_SYNC_WRITE",
SND_SEQ_PORT_CAP_SYNC_WRITE);
+	TCONST(module, PORT_CAP, "SEQ_PORT_CAP_SYNC_READ",
SND_SEQ_PORT_CAP_SYNC_READ);
+	TCONST(module, PORT_CAP, "SEQ_PORT_CAP_SUBS_WRITE",
SND_SEQ_PORT_CAP_SUBS_WRITE);
+	TCONST(module, PORT_CAP, "SEQ_PORT_CAP_SUBS_READ",
SND_SEQ_PORT_CAP_SUBS_READ);
+	TCONST(module, PORT_CAP, "SEQ_PORT_CAP_READ", SND_SEQ_PORT_CAP_READ);
+	TCONST(module, PORT_CAP, "SEQ_PORT_CAP_NO_EXPORT",
SND_SEQ_PORT_CAP_NO_EXPORT);
+	TCONST(module, PORT_CAP, "SEQ_PORT_CAP_DUPLEX", SND_SEQ_PORT_CAP_DUPLEX);
+
+	/* port type */
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_SYNTHESIZER",
SND_SEQ_PORT_TYPE_SYNTHESIZER);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_SYNTH", SND_SEQ_PORT_TYPE_SYNTH);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_SPECIFIC",
SND_SEQ_PORT_TYPE_SPECIFIC);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_SOFTWARE",
SND_SEQ_PORT_TYPE_SOFTWARE);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_SAMPLE", SND_SEQ_PORT_TYPE_SAMPLE);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_PORT", SND_SEQ_PORT_TYPE_PORT);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_MIDI_XG", SND_SEQ_PORT_TYPE_MIDI_XG);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_MIDI_MT32",
SND_SEQ_PORT_TYPE_MIDI_MT32);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_MIDI_GS", SND_SEQ_PORT_TYPE_MIDI_GS);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_MIDI_GM2",
SND_SEQ_PORT_TYPE_MIDI_GM2);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_MIDI_GM", SND_SEQ_PORT_TYPE_MIDI_GM);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_MIDI_GENERIC",
SND_SEQ_PORT_TYPE_MIDI_GENERIC);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_HARDWARE",
SND_SEQ_PORT_TYPE_HARDWARE);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_DIRECT_SAMPLE",
SND_SEQ_PORT_TYPE_DIRECT_SAMPLE);
+	TCONST(module, PORT_TYPE, "SEQ_PORT_TYPE_APPLICATION",
SND_SEQ_PORT_TYPE_APPLICATION);
+
+}
diff -r 5080500e6cd3 setup.py
--- a/setup.py	Sat Nov 03 11:25:08 2007 +0100
+++ b/setup.py	Tue Jan 08 14:32:01 2008 -0300
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
diff -r 5080500e6cd3 test/alsamemdebug.py
--- a/test/alsamemdebug.py	Sat Nov 03 11:25:08 2007 +0100
+++ b/test/alsamemdebug.py	Tue Jan 08 14:32:01 2008 -0300
@@ -6,6 +6,7 @@ import gc

 def debuginit():
 	gc.set_debug(gc.DEBUG_LEAK)
+	print "LEAK: init"

 def debug(what):
 	from sys import getrefcount
@@ -13,7 +14,8 @@ def debug(what):
 	for o in what:
 		if getrefcount(o) - 3 != 1 or \
 		   len(get_referrers(o)) - 2 != 1:
-			print 'LEAK:', hex(id(o)), type(o), getrefcount(o)-3,
len(get_referrers(o))-2
+			print 'LEAK:', o, hex(id(o)), type(o), getrefcount(o)-3,
len(get_referrers(o))-2

 def debugdone():
+	print "LEAK: done"
 	None
diff -r 5080500e6cd3 test/seqtest1.py
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/seqtest1.py	Tue Jan 08 14:32:01 2008 -0300
@@ -0,0 +1,135 @@
+#! /usr/bin/python
+# Sample code for pyalsa Sequencer binding
+# by Aldrin Martoq <amartoq@dcc.uchile.cl>
+# version 2008010801 (UTC: 1199812236 secs)
+#
+# This code is in the public domain,
+# use it as base for creating your pyalsa'
+# alsaseq application.
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
+        if tmp == None:
+            tmp = "N/A"
+        return tmp
+
+    return "name=%s capability=%s type=%s" % (dl(dict, 'name'),
da(dict, 'capability', alsaseq._const_port_cap), da(dict, 'type',
alsaseq._const_port_type))
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
+print "    streams:    %d (%s)" % (sequencer.streams,
alsaseq._const_streams[sequencer.streams])
+print "    mode:       %d (%s)" % (sequencer.mode,
alsaseq._const_mode[sequencer.mode])
+print "    client_id:  %s" % sequencer.client_id
+print
+
+print "02:Changing some parameters ========================"
+sequencer.clientname = 'pepito'
+sequencer.mode = alsaseq.SEQ_BLOCK
+print "    clientname: %s" % sequencer.clientname
+print "    mode:       %d (%s)" % (sequencer.mode,
alsaseq._const_mode[sequencer.mode])
+print
+
+print "03:Creating simple port ============================"
+port_id = sequencer.create_simple_port("myport",
alsaseq.SEQ_PORT_CAP_WRITE | alsaseq.SEQ_PORT_CAP_SUBS_WRITE,
alsaseq.SEQ_PORT_TYPE_APPLICATION)
+print "    port_id:    %s" % port_id
+print
+
+print "04:Getting port info ==============================="
+port_info = sequencer.get_port_info(port_id)
+print "      -->       %s" % dump_portinfo(port_info)
+print "      -->       %s" % port_info
+print
+
+print "05:Listing all client ports ========================"
+connections = sequencer.get_client_ports()
+print "  %s" % (connections)
+print
+
+print "06:Listing all client ports (lenghtly version) ========"
+connections = sequencer.get_client_ports()
+print "  %s" % (connections)
+for clientports in connections:
+        clientname, clientid, portlist = clientports
+        print "    client: %3d    %s" % (clientid, clientname)
+        for port in portlist:
+                portname, portid, connections = port
+                portinfo = sequencer.get_port_info(portid, clientid)
+                print "      port: %3d:%-2d   +-%s\t[%s]" %
(clientid, portid, portname, dump_portinfo(portinfo))
+                readconn, writeconn = connections
+                for c, p in readconn:
+                        print "        connection   to: %d:%d" % (c,p)
+                for c,p in writeconn:
+                        print "        connection from: %d:%d" % (c,p)
+print
+
+print "07:Connecting 'arbitrary' ports... ================="
+sequencer.connect_ports((0, 1), (sequencer.client_id, port_id))
+
+print "08:Listing all client ports (fancy version) ========"
+connections = sequencer.get_client_ports()
+print "  %s" % (connections)
+for clientports in connections:
+        clientname, clientid, portlist = clientports
+        print "    client: %3d    %s" % (clientid, clientname)
+        for port in portlist:
+                portname, portid, connections = port
+                readconn, writeconn = connections
+                for c, p in readconn:
+                        print "        connection   to: %d:%d" % (c,p)
+                for c,p in writeconn:
+                        print "        connection from: %d:%d" % (c,p)
+print
+
+print "09:Disconnecting previous 'arbitrary' port ========="
+sequencer.disconnect_ports((0, 1), (sequencer.client_id, port_id))
+
+print "10:Listing all client ports (fancy version) ========"
+connections = sequencer.get_client_ports()
+print "  %s" % (connections)
+for clientports in connections:
+        clientname, clientid, portlist = clientports
+        print "    client: %3d    %s" % (clientid, clientname)
+        for port in portlist:
+                portname, portid, connections = port
+                readconn, writeconn = connections
+                for c, p in readconn:
+                        print "        connection   to: %d:%d" % (c,p)
+                for c,p in writeconn:
+                        print "        connection from: %d:%d" %init (c,p)
+print
+
+
+print "99:Removing sequencer =============================="
+debug([sequencer])
+del sequencer
+print
+
+debugdone()
+print "All Done."





-- 
Aldrin Martoq
