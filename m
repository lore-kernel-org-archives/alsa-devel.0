From: Fernando Lopez-Lezcano <nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>
Subject: Re: Re: any update on the pcmcia bug blocking
	Audigy2 notebook sound card driver development
Date: 08 Aug 2005 09:40:24 -0700
Message-ID: <1123519224.16205.5.camel@cmn37.stanford.edu>
References: <1ed860e3050807084449b0daac@mail.gmail.com>
	<20050807104332.320aec48.akpm@osdl.org>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <20050807104332.320aec48.akpm-3NddpPZAyC0@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: The Linux Audio Developers' Mailing List <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Cc: linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-08-07 at 10:43, Andrew Morton wrote:
> Raymond Lai <raymond.kk.lai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi all,
> > 
> > I remember there's a kernel pcmcia bug preventing the development for 
> > the Audigy2 pcmcia notebook sound card driver. 
> > 
> > See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> > 
> > Is there any new updates on the situation? Has the bug been fixed? or
> > anyone working on it?
>
> Is it related to http://bugzilla.kernel.org/show_bug.cgi?id=4788 ?

I think not, the card in question is the Creative Audigy 2 ZS PCMCIA
card. I have one I can't use yet :-( The kernel locks hard when ALSA
tries to load the driver. 

This is the last I heard about this issue:
  http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.1/0978.html

-- Fernando
