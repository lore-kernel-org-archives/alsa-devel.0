From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-OSS Duplex bug (revisited)
Date: Mon, 4 Jun 2007 21:42:10 +0100
Message-ID: <200706042142.10888.gineera@aspect135.co.uk>
References: <200705272323.13056.gineera@aspect135.co.uk>
	<200706041253.06880.gineera@aspect135.co.uk>
	<s5hejkrc3m6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ikHZGn2fa01VKWv"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 6794A245D9
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 22:32:00 +0200 (CEST)
In-Reply-To: <s5hejkrc3m6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_ikHZGn2fa01VKWv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 04 June 2007 13:21, you wrote:
> At Mon, 4 Jun 2007 12:53:06 +0100,
> Alan Horstmann wrote:

> > Might it be worth adding a paragraph to 'OSS-Emulation.txt' (or.html), eg
> > as below?  Apart from that I will close off on this issue now!
>
> Looks fine.  Could you make a patch?

Patch attached and also for your html version in case useful.

Also just in case -signed-off etc though the content is from yourselves 
anyway.

Alan

OSS-Emulation.txt-duplex-streams.diff

Add paragraph to the OSS document to clarify correct use of duplex streams.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>



--Boundary-00=_ikHZGn2fa01VKWv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="OSS-Emulation.txt-duplex-streams.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="OSS-Emulation.txt-duplex-streams.diff"

--- alsa-kernel/Documentation/OSS-Emulation-orig.txt	2007-05-02 09:02:20.000000000 +0100
+++ alsa-kernel/Documentation/OSS-Emulation.txt	2007-06-04 20:50:51.000000000 +0100
@@ -278,6 +278,21 @@
 image.
 
 
+Duplex Streams
+==============
+
+Note that when attempting to use a single device file for playback and
+capture, the OSS API provides no way to set the format, sample rate or
+number of channels different in each direction.  Thus
+	io_handle = open("device", O_RDWR)
+will only function correctly if the values are the same in each direction.
+
+To use different values in the two directions, use both
+	input_handle = open("device", O_RDONLY)
+	output_handle = open("device", O_WRONLY)
+and set the values for the corresponding handle.
+
+
 Unsupported Features
 ====================
 

--Boundary-00=_ikHZGn2fa01VKWv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="OSS-Emulation.html-duplex-streams.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="OSS-Emulation.html-duplex-streams.diff"

--- OSS-Emulation-orig.html	2007-06-04 10:57:39.000000000 +0100
+++ OSS-Emulation.html	2007-06-04 21:18:54.000000000 +0100
@@ -381,6 +381,27 @@
 
 
     <p>
+    <h2>Duplex Streams</h2>
+
+    <P>
+      Note that when attempting to use a single device file for playback
+      and capture, the OSS API provides no way to set the format, sample
+      rate or number of channels different in each direction. Thus
+<pre>
+	io_handle = open(&quot;device&quot;, O_RDWR)
+</pre>
+      will only function correctly if the values are the same in each
+      direction.
+    <P>
+      To use different values in the two directions, use both
+<pre>
+	input_handle = open(&quot;device&quot;, O_RDONLY)
+	output_handle = open(&quot;device&quot;, O_WRONLY)
+</pre>
+      and set values for the corresponding handle.
+
+
+    <p>
     <h2>Unsupported Features</h2>
 
     <h3>MMAP on ICE1712 driver</h3>

--Boundary-00=_ikHZGn2fa01VKWv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_ikHZGn2fa01VKWv--
