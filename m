From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] alsa-python: add register_poll to alsaseq
Date: Wed, 21 Apr 2010 16:05:29 +0200
Message-ID: <4BCF0629.4070100@marcansoft.com>
References: <4BCE7868.1020108@marcansoft.com> <4BCEA0BC.3060905@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060801080008070807030804"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 57D2710380E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 16:05:43 +0200 (CEST)
In-Reply-To: <4BCEA0BC.3060905@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060801080008070807030804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 04/21/2010 08:52 AM, Clemens Ladisch wrote:
> Please provide a Signed-off-by tag; we use this also for non-kernel code.

Done.

> This isn't freed; better use alloca().

Whoops. I see this got fixed on hcontrol with 866af7359. I based my
patch on 1.0.21's hcontrol so I missed that fix.

New patch attached.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------060801080008070807030804
Content-Type: text/plain;
 name="0001-Add-register_poll-for-alsaseq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-register_poll-for-alsaseq.patch"

>From f801ff2f940b24c3ee3f27271ec4b249a2c67fb8 Mon Sep 17 00:00:00 2001
From: Hector Martin <hector@marcansoft.com>
Date: Wed, 21 Apr 2010 05:54:49 +0200
Subject: [PATCH] Add register_poll for alsaseq

Signed-off-by: Hector Martin <hector@marcansoft.com>
---
 pyalsa/alsaseq.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/pyalsa/alsaseq.c b/pyalsa/alsaseq.c
index de131a4..bbf6b2e 100644
--- a/pyalsa/alsaseq.c
+++ b/pyalsa/alsaseq.c
@@ -3236,6 +3236,53 @@ Sequencer_stop_queue(SequencerObject *self,
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
+    pfd = alloca(sizeof(struct pollfd) * count);
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
 
 
 
@@ -3309,6 +3356,10 @@ static PyMethodDef Sequencer_methods[] = {
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


--------------060801080008070807030804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060801080008070807030804--
