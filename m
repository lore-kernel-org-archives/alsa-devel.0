From: nick <nixx-nH1cXQZ/6kD10XsdtD+oqA@public.gmane.org>
Subject: Re:M-audio products
Date: Wed, 14 Jan 2004 23:10:39 +0000
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <1074121838.887.12.camel@rubik>
References: <200401111700.i0BH0AER022727@roar.music.columbia.edu>
Reply-To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <200401111700.i0BH0AER022727-cmNoNq8GRA/4Pg51FTPI08Q28FS7N7t4@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: "linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org" <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, linux-audio-dev <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, alsa-devel <alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This card has an ESS Maestro-1 (a.k.a AGOGO / es1948) APU.

But unlike the consumer cards (which use a low quality ac'97 codec) this
card uses nicer CS4222 codecs for better sound. The current drivers only
work in conjunction with an ac'97 codec.


There is no driver for this currently, but I am working on one, although
it will be my first soundcard driver :)

http://dman2044.sourceforge.net/


If anyone has any info that could help me out, I'd be grateful.


Does anyone have data sheets for the es1948?


-Nick

> I have a Dman2044. Oldy but goody with a nice chunky breakout box. 4 by 4.
> 
> Alsa list this for a cs46xx driver.
> Knoppix install detects it as an AGOPO Maestro card
> Alsa's auto install detects it as an es1968, also Maestro.
> 
> None of these alternatives work. The OSS Maestro driver will load but not 
> play. The alsa's will kick at the modprobe
> 
> Any one know what to do? (I have posted on this before.)


-- 
nixx-nH1cXQZ/6kD10XsdtD+oqA@public.gmane.org          |     amSynth lead developer
JabberID: nixx-/eSpBmjxGS4dnm+yROfE0A@public.gmane.org |     http://amsynthe.sf.net
