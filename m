From: Chris Cannam <cannam-8XHTaEMpybawskZW6HU+u9vLeJWuRmrY@public.gmane.org>
Subject: Re: Quick question regarding raw midi access via
	alsa sequencer
Date: Fri, 18 Mar 2005 15:51:21 +0000
Message-ID: <200503181551.22294.cannam@all-day-breakfast.com>
References: <20050318153559.WEAT9404.gx6.fuse.net@64BitBadass>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1250"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050318153559.WEAT9404.gx6.fuse.net@64BitBadass>
Content-Disposition: inline
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Cc: Ivica Ico Bukvic <ico-rDkNP/OoUoU@public.gmane.org>, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Friday 18 Mar 2005 15:40, Ivica Ico Bukvic wrote:
> 2) The other option is obviously to use alsa-sequencer API but in that case
> is there a way to simply convert the stream of received MIDI data into raw
> midi format so that I can use my built-in raw MIDI parsing engine for
> parsing the messages?

If I understand the requirement right, then the snd_midi_event_* API can do 
it: see <alsa/seq_midi_event.h>.  I've used this a couple of times in the 
DSSI examples source code, and I'm sure there are plenty of examples 
elsewhere.


Chris
