From: "Ivica Ico Bukvic" <ico-rDkNP/OoUoU@public.gmane.org>
Subject: Quick question regarding raw midi access via alsa
	sequencer
Date: Fri, 18 Mar 2005 10:40:17 -0500
Message-ID: <20050318153559.WEAT9404.gx6.fuse.net@64BitBadass>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: 'The Linux Audio Developers' Mailing List' <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I did a bit of hacking on my app trying to make it alsa sequencer compatible
but did not want to do too much changing in terms of how it deals with raw
MIDI data. From looking at the API reference it seems that I have 2 choices:

1) Use raw midi option and specify "virtual" name which makes my app's MIDI
I/O appear in the alsa sequencer, *but* does not give me an option of
changing the node names which obviously is very important when it comes to
working with a lot of apps concurrently. So therefore here's my first
question:

Is there a way to specify a "virtual" port so that I can receive raw MIDI
data, have ports show in the alsa sequencer and on top of that be able to
*rename* the port as necessary?

2) The other option is obviously to use alsa-sequencer API but in that case
is there a way to simply convert the stream of received MIDI data into raw
midi format so that I can use my built-in raw MIDI parsing engine for
parsing the messages?

Any help is greatly appreciated!

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 


-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.7.3 - Release Date: 3/15/2005
 
