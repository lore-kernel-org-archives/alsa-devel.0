From: Andy Robinson <andy@seventhstring.com>
Subject: OSS emulation buffer size
Date: Mon, 31 Jan 2005 13:07:53 +0000
Message-ID: <1107176873.6815.40.camel@andys_dellm60.ss82amr.net>
References: <20050131041531.5A33988479@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050131041531.5A33988479@sc8-sf-spam1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I'm trying to find out how to change the size of the buffer which
ALSA provides for its OSS emulation. I hope this is the right place to
ask. I've tried alsa-user but got no reply.

I have 2.6.8 kernel (Mandrake 10.1) and ALSA 1.0.6 though in fact this
problem affects other users of my software, not just me.

AFAIK, OSS always provided 64k unless you recompiled your kernel to
change it.

But the ALSA OSS emulation provides differing amounts, usually less, and
different from one installation to another. Sometimes as little as 2k.

Where is this controlled from?

In the app (which I write) which is using OSS I can
SNDCTL_DSP_SETFRAGMENT but this won't increase the total size.

I have also tried
echo "transcribe 32 2048" >/proc/asound/card0/pcm0p/oss
which does have some effect - it then gives me 32 * 512 byte fragments
instead of 4 * 4k - so total size again has not changed. At least this
confirms that it is the ALSA emulation that my app is talking to.

How to increase the total buffer size to 32k or 64k?

Of course I realise that if I gave the app ALSA support then the problem
would go away, but it would be simpler if there was a way to make ALSA
allocate a decent amount of buffer to its OSS emulation. Then it would
just work.

Thanks,
Andy Robinson, Seventh String Software, www.seventhstring.com



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
