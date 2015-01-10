From: Hector Martin <marcan@marcan.st>
Subject: [PATCH] pyalsa: alsaseq: fix memory leaks
Date: Sun, 11 Jan 2015 04:02:11 +0900
Message-ID: <1420916531-29724-1-git-send-email-marcan@marcan.st>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.marcansoft.com (marcansoft.com [213.138.101.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 692A0260439
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 20:02:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hector Martin <marcan@marcan.st>
List-Id: alsa-devel@alsa-project.org

Fix a bunch of dangling reference issues. Also switch to Py_BuildValue
where appropriate, since that makes it easier to build complex
dictionary/tuple structures without leaking integer/string references.

Signed-off-by: Hector Martin <marcan@marcan.st>
---

I haven't looked at the other parts of pyalsa; those could probably use
some looking over too. I went through alsaseq since I'm writing a
long-running MIDI client and I noticed it was leaking all event objects.

pyalsa/alsaseq.c | 156 +++++++++++++++++++++----------------------------------
 1 file changed, 58 insertions(+), 98 deletions(-)

diff --git a/pyalsa/alsaseq.c b/pyalsa/alsaseq.c
index e34d3b4..ce332ed 100644
--- a/pyalsa/alsaseq.c
+++ b/pyalsa/alsaseq.c
@@ -124,7 +124,9 @@
     if (PyModule_AddObject(module, name, tmp) < 0) {			\
       return;								\
     }									\
-    PyDict_SetItem(TDICT(subtype), PyInt_FromLong(value), tmp);		\
+    PyObject *key = PyInt_FromLong(value);				\
+    PyDict_SetItem(TDICT(subtype), key, tmp);				\
+    Py_DECREF(key);							\
   }
 
 #define TCONSTRETURN(subtype, value) {			\
@@ -199,8 +201,11 @@
   PyDict_SetItemString(dict, name, object)
 
 /* sets a integer into the dict */
-#define SETDICTINT(name, value)					\
-  PyDict_SetItemString(dict, name, PyInt_FromLong(value))
+#define SETDICTINT(name, value) {		\
+    PyObject *val = PyInt_FromLong(value);	\
+    PyDict_SetItemString(dict, name, val);	\
+    Py_DECREF(val);				\
+  }
 
 /* sets note info dict (used by SeqEvent_get_data) */
 #define SETDICT_NOTE3 {					\
@@ -288,6 +293,7 @@
       PyList_SetItem(list, i, PyInt_FromLong(t[i]));	\
     }							\
     SETDICTOBJ("ext", list);				\
+    Py_DECREF(list);					\
   }
 
 /* gets integer from python param */
@@ -1767,7 +1773,7 @@ SeqEvent_repr(SeqEventObject *self) {
 
   return PyString_FromFormat("<alsaseq.SeqEvent type=%s(%d) flags=%d tag=%d "
 			     "queue=%d time=%s(%u.%u) from=%d:%d to=%d:%d "
-			     "at 0x%p>",
+			     "at %p>",
 			     typestr,
 			     self->event->type, self->event->flags,
 			     self->event->tag, self->event->queue,
@@ -2367,34 +2373,23 @@ _query_connections_list(snd_seq_t *handle,
 
   PyObject *list = PyList_New(0);
   int index = 0;
-  long tmplong;
   snd_seq_query_subscribe_set_type(query, type);
   snd_seq_query_subscribe_set_index(query, index);
   while (snd_seq_query_port_subscribers(handle, query) >= 0) {
     const snd_seq_addr_t *addr =
       snd_seq_query_subscribe_get_addr(query);
 
-    PyObject *dict = PyDict_New();
-
-    tmplong = snd_seq_query_subscribe_get_queue(query);
-    PyDict_SetItemString(dict, "queue", PyInt_FromLong(tmplong));
-
-    tmplong = snd_seq_query_subscribe_get_exclusive(query);
-    PyDict_SetItemString(dict, "exclusive", PyInt_FromLong(tmplong));
-
-    tmplong = snd_seq_query_subscribe_get_time_update(query);
-    PyDict_SetItemString(dict, "time_update", PyInt_FromLong(tmplong));
-
-    tmplong = snd_seq_query_subscribe_get_time_real(query);
-    PyDict_SetItemString(dict, "time_real", PyInt_FromLong(tmplong));
-
-
-    PyObject *tuple = PyTuple_New(3);
-    PyTuple_SetItem(tuple, 0, PyInt_FromLong(addr->client));
-    PyTuple_SetItem(tuple, 1, PyInt_FromLong(addr->port));
-    PyTuple_SetItem(tuple, 2, dict);
+    PyObject *tuple = Py_BuildValue(
+        "(ii{sisisisi})",
+        (int)addr->client,
+        (int)addr->port,
+        "queue", (int)snd_seq_query_subscribe_get_queue(query),
+        "exclusive", (int)snd_seq_query_subscribe_get_exclusive(query),
+        "time_update", (int)snd_seq_query_subscribe_get_time_update(query),
+        "time_real", (int)snd_seq_query_subscribe_get_time_real(query));
 
     PyList_Append(list, tuple);
+    Py_DECREF(tuple);
     snd_seq_query_subscribe_set_index(query, ++index);
   }
   return list;
@@ -2466,11 +2461,13 @@ Sequencer_connection_list(SequencerObject *self,
       PyTuple_SetItem(porttuple, 2, conntuple);
 
       PyList_Append(portlist, porttuple);
+      Py_DECREF(porttuple);
     }
     PyTuple_SetItem(tuple, 2, portlist);
 
     /* append list of port tuples */
     PyList_Append(list, tuple);
+    Py_DECREF(tuple);
   }
 
   return list;
@@ -2506,9 +2503,6 @@ Sequencer_get_client_info(SequencerObject *self,
   snd_seq_client_info_t *cinfo;
   int client_id = -1;
   int ret;
-  PyObject *tmpobj;
-  long tmplong;
-  const char * tmpchar;
   char *kwlist[] = { "client_id", NULL};
 
   if (!PyArg_ParseTupleAndKeywords(args, kwds, "|i", kwlist,
@@ -2532,37 +2526,21 @@ Sequencer_get_client_info(SequencerObject *self,
     }
   }
 
-  PyObject *dict = PyDict_New();
-  if (dict == NULL) {
-    return NULL;
-  }
-
-  TCONSTASSIGN(ADDR_CLIENT, client_id, tmpobj);
-  PyDict_SetItemString(dict, "id", tmpobj);
-
-  tmplong = snd_seq_client_info_get_type(cinfo);
-  TCONSTASSIGN(CLIENT_TYPE, tmplong, tmpobj);
-  PyDict_SetItemString(dict, "type", tmpobj);
-
-  tmpchar = snd_seq_client_info_get_name(cinfo);
-  tmpchar = (tmpchar == NULL ? "" : tmpchar);
-  PyDict_SetItemString(dict, "name", PyString_FromString(tmpchar));
-
-  tmplong = snd_seq_client_info_get_broadcast_filter(cinfo);
-  PyDict_SetItemString(dict, "broadcast_filter", PyInt_FromLong(tmplong));
-
-  tmplong = snd_seq_client_info_get_error_bounce(cinfo);
-  PyDict_SetItemString(dict, "error_bounce", PyInt_FromLong(tmplong));
-
-  tmpchar = (const char *)snd_seq_client_info_get_event_filter(cinfo);
-  tmpchar = (tmpchar == NULL ? "" : tmpchar);
-  PyDict_SetItemString(dict, "event_filter", PyString_FromString(tmpchar));
+  PyObject *d_id, *d_type;
+  TCONSTASSIGN(ADDR_CLIENT, client_id, d_id);
+  TCONSTASSIGN(CLIENT_TYPE, snd_seq_client_info_get_type(cinfo), d_type);
+  const char *d_name = snd_seq_client_info_get_name(cinfo);
 
-  tmplong = snd_seq_client_info_get_num_ports(cinfo);
-  PyDict_SetItemString(dict, "num_ports", PyInt_FromLong(tmplong));
-
-  tmplong = snd_seq_client_info_get_event_lost(cinfo);
-  PyDict_SetItemString(dict, "event_lost", PyInt_FromLong(tmplong));
+  PyObject *dict = Py_BuildValue(
+      "{sNsNsssisiss#sisi}",
+      "id", d_id,
+      "type", d_type,
+      "name", d_name == NULL ? "" : d_name,
+      "broadcast_filter", (int)snd_seq_client_info_get_broadcast_filter(cinfo),
+      "error_bounce", (int)snd_seq_client_info_get_error_bounce(cinfo),
+      "event_filter", snd_seq_client_info_get_event_filter(cinfo), 32,
+      "num_ports", (int)snd_seq_client_info_get_num_ports(cinfo),
+      "event_lost", (int)snd_seq_client_info_get_event_lost(cinfo));
 
   return dict;
 }
@@ -2594,8 +2572,6 @@ Sequencer_get_port_info(SequencerObject *self,
   snd_seq_client_info_t *cinfo;
   int port_id;
   int client_id;
-  const char *tmpchar;
-  long tmplong;
   int ret;
   char *kwlist[] = { "port_id", "client_id", NULL };
 
@@ -2612,11 +2588,6 @@ Sequencer_get_port_info(SequencerObject *self,
     return NULL;
   }
 
-  PyObject *dict = PyDict_New();
-  if (dict == NULL) {
-    return NULL;
-  }
-
   snd_seq_port_info_alloca(&pinfo);
   ret = snd_seq_get_any_port_info(self->handle, client_id,
 				  port_id, pinfo);
@@ -2625,17 +2596,11 @@ Sequencer_get_port_info(SequencerObject *self,
     return NULL;
   }
 
-  tmpchar = snd_seq_port_info_get_name(pinfo);
-  tmpchar = (tmpchar == NULL ? "" : tmpchar);
-  PyDict_SetItemString(dict, "name", PyString_FromString(tmpchar));
-
-  tmplong = snd_seq_port_info_get_capability(pinfo);
-  PyDict_SetItemString(dict, "capability", PyInt_FromLong(tmplong));
-
-  tmplong = snd_seq_port_info_get_type(pinfo);
-  PyDict_SetItemString(dict, "type", PyInt_FromLong(tmplong));
-
-  return dict;
+  return Py_BuildValue(
+      "{sssIsI}",
+      "name", snd_seq_port_info_get_name(pinfo),
+      "capability", (unsigned int)snd_seq_port_info_get_capability(pinfo),
+      "type", (unsigned int)snd_seq_port_info_get_type(pinfo));
 }
 
 /** alsaseq.Sequencer connect_ports() method: __doc__ */
@@ -2768,7 +2733,6 @@ Sequencer_get_connect_info(SequencerObject *self,
   snd_seq_addr_t sender, dest;
   snd_seq_port_subscribe_t *sinfo;
   int ret;
-  long tmplong;
 
   if (!PyArg_ParseTuple(args, "(BB)(BB)", &(sender.client),
 	                &(sender.port), &(dest.client), &(dest.port))) {
@@ -2786,21 +2750,12 @@ Sequencer_get_connect_info(SequencerObject *self,
     return NULL;
   }
 
-  PyObject *dict = PyDict_New();
-
-  tmplong = snd_seq_port_subscribe_get_queue(sinfo);
-  PyDict_SetItemString(dict, "queue", PyInt_FromLong(tmplong));
-
-  tmplong = snd_seq_port_subscribe_get_exclusive(sinfo);
-  PyDict_SetItemString(dict, "exclusive", PyInt_FromLong(tmplong));
-
-  tmplong = snd_seq_port_subscribe_get_time_update(sinfo);
-  PyDict_SetItemString(dict, "time_update", PyInt_FromLong(tmplong));
-
-  tmplong = snd_seq_port_subscribe_get_time_real(sinfo);
-  PyDict_SetItemString(dict, "time_real", PyInt_FromLong(tmplong));
-
-  return dict;
+  return Py_BuildValue(
+      "{sisisisi}",
+      "queue", (int)snd_seq_port_subscribe_get_queue(sinfo),
+      "exclusive", (int)snd_seq_port_subscribe_get_exclusive(sinfo),
+      "time_update", (int)snd_seq_port_subscribe_get_time_update(sinfo),
+      "time_real", (int)snd_seq_port_subscribe_get_time_real(sinfo));
 }
 
 /** alsaseq.Sequencer receive_events() method: __doc__ */
@@ -2878,6 +2833,7 @@ Sequencer_receive_events(SequencerObject *self,
     }
 
     PyList_Append(list, SeqEventObject);
+    Py_DECREF(SeqEventObject);
 
     maxevents --;
 
@@ -3263,19 +3219,23 @@ Sequencer_registerpoll(SequencerObject *self, PyObject *args, PyObject *kwds)
     if (count <= 0)
         Py_RETURN_NONE;
 
-    reg = PyObject_GetAttr(pollObj, PyString_InternFromString("register"));
+    reg = PyObject_GetAttrString(pollObj, "register");
+    if (!reg)
+        return NULL;
 
     for (i = 0; i < count; i++) {
         t = PyTuple_New(2);
-        if (t) {
-            PyTuple_SET_ITEM(t, 0, PyInt_FromLong(pfd[i].fd));
-            PyTuple_SET_ITEM(t, 1, PyInt_FromLong(pfd[i].events));
-            Py_XDECREF(PyObject_CallObject(reg, t));
-            Py_DECREF(t);
+        if (!t) {
+            Py_DECREF(reg);
+            return NULL;
         }
+        PyTuple_SET_ITEM(t, 0, PyInt_FromLong(pfd[i].fd));
+        PyTuple_SET_ITEM(t, 1, PyInt_FromLong(pfd[i].events));
+        Py_XDECREF(PyObject_CallObject(reg, t));
+        Py_DECREF(t);
     }
 
-    Py_XDECREF(reg);
+    Py_DECREF(reg);
 
     Py_RETURN_NONE;
 }
-- 
2.2.1
