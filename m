From: "Ivica Ico Bukvic" <ico-rDkNP/OoUoU@public.gmane.org>
Subject: Jacklaunch vs. asoundrc jack plugin
Date: Tue, 5 Apr 2005 20:19:00 -0400
Message-ID: <20050406001408.ZGJX9404.gx6.fuse.net@64BitBadass>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: 'The Linux Audio Developers' Mailing List' <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, 'A list for linux audio users' <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi all,

First of all, please accept my apologies for cross-posting. I simply feel
that this issue may be of interest to all these groups.

After some research and experimenting with jacklaunch (libjackasyn) as well
as alsa .asoundrc jack plugin I found out that very few apps actually
cooperate with either of these.

Jack plugin for asoundrc practically works only with aplay/arecord and
freebirth. Audacity doesn't cooperate with either, while jacklaunch even
though it has been reported to work with sweep doesn't on my machines (mdk
10.0 and 10.1).

I've tested latest jack, sweep, Alsa 1.0.6 and 1.0.7 (I did not go beyond
that as 1.0.8 has apparent issues with hdsploader) and had no luck
whatsoever.

Hence, I am just wondering at this point whether asoundrc jack is still in
the testing phase (some of the errors that apps reported trying to use jack
plug were due to inability to probe some info from the alsa driver which
implies possible incompleteness of the implementation or weird probing from
the app's side) and also whether anyone has had better luck than myself
using either of these with audacity, sweep, and other non-jackified, yet
important Linux audio apps via either of the aforementioned ways.

FWIW, it would be really nice to see some united effort to jackify some of
the other critical Linux audio apps even if their original authors do not
feel like that is one of their priorities (I know, I know, if I am so
interested in such developments then I might as well set an example by doing
what I am advocating, which is something I would love to do, but
unfortunately currently the notion of "free time" in my life is but a joke).

Many thanks!

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 

-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.9.3 - Release Date: 4/5/2005
 
