From: Michael Renzmann <alsa@nospam.otaku42.de>
Subject: Am I on the right way?
Date: Thu, 18 Mar 2004 23:41:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405A25B2.5030907@nospam.otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all.

I'm new to Alsa and its concepts, so I'd like to ask if the following
assumptions are correct.

A short explanation on the background: I'm currently examining different
Voice over IP softphones on Linux. Every program that I've seen so far
has the same limitation: it works with OSS. I guess you all know the
drawbacks: I have to decide whether I want to have the softphone
running, so that I can be called, or if I want to listen to some MP3s
without being reachable by VoIP. Yes, I know of libaoss, but this causes
some new problems.

As we have a very flexible sound system available for Linux, it would be
nice if there also was a softphone that makes use of this. Here is my idea:

One of the tasks the softphone has is to record the voice of the local
caller and encode with one of several standard codecs (such as G.711,
GSM or whatever). The sofphone implementations I've seen always handle
that codec-stuff by themselves.

If I understood the concept of Alsa correctly, it should be possible to
implement the different codecs as PCM plugins and "route the sound"
through them:

Soundcard <--> PCM-Plugin-Codec <--> Softphone

By defining several "routes", usage of different codecs would be simple,
as long as it exists in the form of a PCM plugin. Benefit: handling of
sound stuff is delegated to a part of the system that already has
everything it needs to care about this task: Alsa. The softphone itself
just needs to know which path is handling which Codec, and just has to
read/write from/to that path.

Are these assumptions correct? If so, do you have any pointers for me
where I can learn more about the implementation of such PCM plugins?

As you most likely can see, I'm unaware of the correct terms in the Alsa
context (for example, I'm sure that you don't actually talk of "paths"
for what I've described above). Please bear with me, I'm new to this
stuff :)

I'd like to hear your oppinion about this idea. Would it be possible to
do? Is it a good idea to go this path?

Bye, Mike



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
