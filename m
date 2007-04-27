From: Gordon Miller <gordonamiller@btinternet.com>
Subject: dsnoop issues
Date: Fri, 27 Apr 2007 13:27:00 +0100
Message-ID: <4631EC14.2060802@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp812.mail.ird.yahoo.com (smtp812.mail.ird.yahoo.com
	[217.146.188.72]) by alsa0.perex.cz (Postfix) with SMTP id DBCA024341
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 14:27:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

All my snd_pcm_readi calls return too few frames. Also when I switch to 
stereo, the sound is muted. I cannot change this by adjusting period & 
buffer sizes. dsnoop is enabled by default. The documentation for 
snd_pcm_readi says that the only way that the frame count can be short 
is because of a signal or xrun. Well this clearly isn't the case.

I think that direct snoop is the cause of this. Are there any remedies ? 
because I am roundly SICK of being told that my application must be 
wrong "because everyone else's works". I have spent the last 3 weeks 
debugging an app - that always worked properly - because of the faulty 
dsnoop implementation.

It is abundantly clear that dsnoop is far from ready for use, but I am 
prepared to put some work into this.
Whose idea was it to enable dsnoop by default, when it doesn't even work 
? I was quite happy with OSS. Changing everything to be alsa entailed a 
lot of work, and I am beginning to think it was a complete waste of my time.

ICE1712, 2.6.20.6 kernel, alsa 1.0.14rc1

Gordon
