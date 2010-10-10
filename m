From: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [LAU] [alsa-devel] Alsamixer-Qt4 0.5.0 released
Date: Sun, 10 Oct 2010 14:20:00 -0700
Message-ID: <AANLkTik0dkK=otsWQKEf2x2ViQ7Gup_pzCj2V4e0yqkD@mail.gmail.com>
References: <4CB0D360.2010201@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <4CB0D360.2010201-Mmb7MZpHnFY@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: "Sebastian H." <vand2-Mmb7MZpHnFY@public.gmane.org>, linux-audio-user <linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
Cc: "alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 9, 2010 at 1:41 PM, Sebastian H. <vand2-Mmb7MZpHnFY@public.gmane.org> wrote:
> ( http://xwmw.org/alsamixer-qt4/ )
> After an almost complete rewrite to support separate channels views
> in the main sliders and switches areas, Alsamixer-Qt4 0.5.0 is now
> available.

This is a vast improvement over the previous version for those with
envy24-based cards where the previous separate channel views were
problematic ( http://www.spinics.net/linux/lists/alsa-devel/msg36494.html
).

Here's how this latest alsamixer-qt4 looks against the equivalent
controlpanels from http://mudita24.googlecode.com (svn trunk edition):
http://nielsmayer.com/envy24control/alsamixer-qt4-playback-envy24.png
http://nielsmayer.com/envy24control/alsamixer-qt4-capture-envy24.png

One thing that takes getting used to: the controls that are "muted" in
envy24control/mudita24 are unchecked in alsamixer-qt4 -- the active or
captured channels are the ones showing the checkbox selection.

-- Niels
http://nielsmayer.com
