From: "Ivica Ico Bukvic" <ico-rDkNP/OoUoU@public.gmane.org>
Subject: RE: Quick question regarding raw midi access
	viaalsa sequencer
Date: Fri, 18 Mar 2005 15:14:24 -0500
Message-ID: <20050318200922.XOWR20940.gx5.fuse.net@64BitBadass>
References: <200503181551.22294.cannam@all-day-breakfast.com>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503181551.22294.cannam-8XHTaEMpybawskZW6HU+u9vLeJWuRmrY@public.gmane.org>
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

Thanks all for your replies. I tried messing with the snd_midi_event_* stuff
but none provided proper data as when I tried accessing the struct with
8-bit data I got number like 15360 or something like that. I am sure that I
am misreading something or simply doing something incorrectly, pointers to a
working code would be highly appreciated!

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 
> -----Original Message-----
> From: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org [mailto:linux-audio-dev-
> bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org] On Behalf Of Chris Cannam
> Sent: Friday, March 18, 2005 10:51 AM
> To: linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
> Cc: Ivica Ico Bukvic; alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [linux-audio-dev] Quick question regarding raw midi access
> viaalsa sequencer
> 
> On Friday 18 Mar 2005 15:40, Ivica Ico Bukvic wrote:
> > 2) The other option is obviously to use alsa-sequencer API but in that
> case
> > is there a way to simply convert the stream of received MIDI data into
> raw
> > midi format so that I can use my built-in raw MIDI parsing engine for
> > parsing the messages?
> 
> If I understand the requirement right, then the snd_midi_event_* API can
> do
> it: see <alsa/seq_midi_event.h>.  I've used this a couple of times in the
> DSSI examples source code, and I'm sure there are plenty of examples
> elsewhere.
> 
> 
> Chris
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
 
