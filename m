From: Andy Robinson <andy@seventhstring.com>
Subject: Re: OSS emulation buffer size
Date: Mon, 31 Jan 2005 18:05:50 +0000
Message-ID: <1107194750.6850.13.camel@andys_dellm60.ss82amr.net>
References: <20050131180005.637F588D21@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050131180005.637F588D21@sc8-sf-spam1.sourceforge.net>
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

> From: Clemens Ladisch <clemens@ladisch.de>
> Subject: Re: [Alsa-devel] OSS emulation buffer size
> What sound card do you have?
> What are the contents of /proc/asound/card0/pcm0p/sub0/prealloc?  Try
> changing it.

This is definitely a step in the right direction. Currently this says
"64" (though I only get 16k in the OSS emulation).

I can change it up to 128 (if I ask for more than 128, it is ignored and
the file contents don't change). But when I set it to 128 I get OSS
buffer of 32k !!! I've tried many things but this is the first time I've
ever seen the ALSA-OSS buffer increase.

It seems that only a quarter of the "prealloc" buffer is being allocated
to the OSS emulation. I would be even more grateful if you could suggest
how to either get more than 128k total, or else to allocate a larger
proportion of that 128k to the OSS buffer. Ideally I'd like to see 64k,
same as native OSS itself provides.

My soundcard is Intel 82801DB-ICH4 (DELL Precision M60) but this issue
affects not just me, also other users of my software.

Thanks,
Andy Robinson, Seventh String Software, www.seventhstring.com



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
