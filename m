From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib plugin devel
Date: Mon, 24 Jan 2005 10:24:34 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0501241023030.2256@pnote.perex-int.cz>
References: <41F4AF11.2090109@xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41F4AF11.2090109@xmission.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brad Midgley <bmidgley@xmission.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Jan 2005, Brad Midgley wrote:

> Hi
> 
> I've started working on an alsa-lib plugin to send audio to a bluetooth 
> device (see http://bluetooth-alsa.sf.net)
> 
> I stubbed it out so I can see that it gets invoked when I address it 
> directly with
> 
> 	aplay -B 1000000 -D pcm.a2dp sound.wav
> 
> And I can see it is invoking the plugin code (just filled in with a 
> bunch of printf's). What I'm struggling with is how to make this driver 
> appear to clients that use alsa-lib. In the simplest case,
> 
> 	aplay --list-devices

The control interface is used here (alsa-lib/src/control/).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
