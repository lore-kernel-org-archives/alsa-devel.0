From: "Ivica Ico Bukvic" <ico-rDkNP/OoUoU@public.gmane.org>
Subject: RE: Quick question regarding raw midi access
	viaalsa sequencer
Date: Fri, 18 Mar 2005 15:14:41 -0500
Message-ID: <20050318200939.XOXR20940.gx5.fuse.net@64BitBadass>
References: <200503181550.j2IFoWvj011640@localhost.localdomain>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503181550.j2IFoWvj011640-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: 'The Linux Audio Developers' Mailing List' <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Cc: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Thanks Paul,

I look into that particular file.

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 

> -----Original Message-----
> From: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org [mailto:linux-audio-dev-
> bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org] On Behalf Of Paul Davis
> Sent: Friday, March 18, 2005 10:51 AM
> To: The Linux Audio Developers' Mailing List
> Cc: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [linux-audio-dev] Quick question regarding raw midi access
> viaalsa sequencer
> 
> >I did a bit of hacking on my app trying to make it alsa sequencer
> compatible
> >but did not want to do too much changing in terms of how it deals with
> raw
> >MIDI data. From looking at the API reference it seems that I have 2
> choices:
> 
> libmidi++ in the ardour source tree has what you need. at least as a
> model. ardour writes raw MIDI, never uses the sequencer API. libmidi++
> provides "port" objects which support that, regardless of whether they
> correspond to a raw MIDI port, a FIFO (literally), CoreMIDI or ALSA
> sequencer.
> 
> see alsasequencer_midiport.cc for details.
> 
> --p
> 
> --
> No virus found in this incoming message.
> Checked by AVG Anti-Virus.
> Version: 7.0.308 / Virus Database: 266.7.3 - Release Date: 3/15/2005
> 

-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.7.3 - Release Date: 3/15/2005
 
