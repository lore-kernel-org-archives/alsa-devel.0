From: "Ivica Bukvic" <ico=rDkNP/OoUoU@public.gmane.org>
Subject: question about libalsaplayer's functionality (and
	its possible incorporation in my app)
Date: Fri, 24 Oct 2003 21:22:57 -0400
Sender: linux-audio-dev-bounces=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <001201c39a96$85acc490$0f02a8c0@ICO>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces@music.columbia.edu>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev@music.columbia.edu>
List-Help: <mailto:linux-audio-dev-request@music.columbia.edu?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=subscribe>
Errors-To: linux-audio-dev-bounces@music.columbia.edu
To: linux-audio-user=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Cc: alsa-user=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andy=MqbaIyFPqQhM656bX5wj8A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi all, I've tried contacting the maintainer of the project (Andy), but
he never bothered to reply, so now I am taking this question to all of
you out there that might have had exposure to this interesting library.
Does anyone know what is the current status of the whole project anyhow?
Any help on this matter is greatly appreciated! When answering any of
the given questions, please include the question in your reply. Thank
you very much! 

So here's the excerpt from the letter:

I've recently decided to incorporate libalsaplayer-like functionality
the upcoming version of my app RTMix. However, with having a particular
feature in mind I am wondering whether libalsaplayer provides that and
if not, whether you'd be willing to add it (or let me add it, although
that might get messy since I am not too familiar with the inner workings
of the lib). So, here it goes:

Apart from all the wonderful features libalsaplayer offers, I am looking
for some additional ones:

I would like to be able to indefinitely loop specific "ranges" of a
particular soundfile (i.e. 2.2secs-4.12secs or whatever).

1. Is it possible to do this and have music continually loop even if one
changes the direction of playing so that when the alsaplayer runs out of
the looping material in each direction that it just jumps back onto the
other end of the loop and contiues on (kind of like a ring-buffer)?

2. Is it also possible to do this kind of looping on the whole soundfile
(the gui version of alsaplayer always stops if I let it play 'til the
end or the beginning, depending in which direction I am going).

3. Is it possible to define loop points by addressing a particular
sample number rather than giving time in seconds?

4. How stable is alsaplayer when looping really small chunks of sound
(i.e. like 5 sample loop)?

5. Is alsaplayer capable of ramping such loop points by attenuating
let's say ending 20 samples (it would be cool if this number could be
user-selectable) and then ramping up the beginning 20 samples in order
to alleviate the "pop" that happens when looping a sound where waveforms
at the beginning and the end do not align?

6. If the feature in question 5 does not exist is there a way to control
output level of a player on a per-sample basis via callback so that one
can implement that outside of the lib?

7. If neither 5 or 6 are possible, would you be willing to implement
such functionality (i.e. a toggle_ramp( bool ); and set_ramp_length( int
); callbacks or something similar.

I would greatly appreciate your feedback on this matter as that will
greatly assist me in determining how to go about implementing such
functionality in my app.

Thank you very much! Looking forward to hearing from you. Sincerely,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico

P.S. How do you implement reading of a sound faster and slower than it
sounds in such a gradual fashion? Do you adjust the sampling rate of the
DSP and if so does that affect other streams coming from the
libalsaplayer, or is this something that is sound-specific (and if so,
how)?
