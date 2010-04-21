From: Hector Martin <hector@marcansoft.com>
Subject: [PATCH] alsa-python: add register_poll to alsaseq
Date: Wed, 21 Apr 2010 06:00:40 +0200
Message-ID: <4BCE7868.1020108@marcansoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080100090701000909000606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id B21A91037F9
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 06:00:53 +0200 (CEST)
Received: from [IPv6:2001:470:1f09:800:2a0:d1ff:feab:c75b]
	(raider.home.marcansoft.com
	[IPv6:2001:470:1f09:800:2a0:d1ff:feab:c75b])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.marcansoft.com (Postfix) with ESMTPSA id C16C665B38
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 06:00:42 +0200 (CEST)
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

This is a multi-part message in MIME format.
--------------080100090701000909000606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Attached patch adds register_poll to the sequencer bindings to support
nonblocking sequencer access with the select module.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------080100090701000909000606
Content-Type: text/plain;
 name="0001-Add-register_poll-for-alsaseq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-register_poll-for-alsaseq.patch"

>From db1a07ad9e9076f258d1ff871955eedc7d34ae9c Mon Sep 17 00:00:00 2001
From: Hector Martin <hector@marcansoft.com>
Date: Wed, 21 Apr 2010 05:54:49 +0200
Subject: [PATCH] Add register_poll for alsaseq

---
 pyalsa/alsaseq.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/pyalsa/alsaseq.c b/pyalsa/alsaseq.c
index de131a4..fbab6da 100644
--- a/pyalsa/alsaseq.c
+++ b/pyalsa/alsaseq.c
@@ -3236,6 +3236,55 @@ Sequencer_stop_queue(SequencerObject *self,
   Py_RETURN_NONE;
 }
 
+PyDoc_STRVAR(Sequencer_registerpoll__doc__,
+"register_poll(pollObj, input=False, output=False) -- Register poll file descriptors.");
+
+static PyObject *
+Sequencer_registerpoll(SequencerObject *self, PyObject *args, PyObject *kwds)
+{
+    PyObject *pollObj, *reg, *t;
+    struct pollfd *pfd;
+    int i, count;
+    int input = 0;
+    int output = 0;
+    int mode = POLLIN|POLLOUT;
+
+    static char * kwlist[] = { "pollObj", "input", "output", NULL };
+
+    if (!PyArg_ParseTupleAndKeywords(args, kwds, "O|ii", kwlist, &pollObj, &input, &output))
+        return NULL;
+
+    if (input && !output)
+        mode = POLLIN;
+    else if (!input && output)
+        mode = POLLOUT;
+
+    count = snd_seq_poll_descriptors_count(self->handle, mode);
+    if (count <= 0)
+        Py_RETURN_NONE;
+    pfd = malloc(sizeof(struct pollfd) * count);
+    if (pfd == NULL)
+        Py_RETURN_NONE;
+    count = snd_seq_poll_descriptors(self->handle, pfd, count, mode);
+    if (count <= 0)
+        Py_RETURN_NONE;
+
+    reg = PyObject_GetAttr(pollObj, PyString_InternFromString("register"));
+
+    for (i = 0; i < count; i++) {
+        t = PyTuple_New(2);
+        if (t) {
+            PyTuple_SET_ITEM(t, 0, PyInt_FromLong(pfd[i].fd));
+            PyTuple_SET_ITEM(t, 1, PyInt_FromLong(pfd[i].events));
+            Py_XDECREF(PyObject_CallObject(reg, t));
+            Py_DECREF(t);
+        }
+    }
+
+    Py_XDECREF(reg);
+
+    Py_RETURN_NONE;
+}
 
 
 
@@ -3309,6 +3358,10 @@ static PyMethodDef Sequencer_methods[] = {
    (PyCFunction) Sequencer_stop_queue,
    METH_VARARGS | METH_KEYWORDS,
    Sequencer_stop_queue__doc__},
+  {"register_poll",
+   (PyCFunction) Sequencer_registerpoll,
+   METH_VARARGS | METH_KEYWORDS,
+   Sequencer_registerpoll__doc__},
   {NULL}
 };
 
-- 
1.6.4.4


--------------080100090701000909000606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080100090701000909000606--
