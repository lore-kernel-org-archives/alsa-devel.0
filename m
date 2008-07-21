From: Nick Thompson <rextanka@comcast.net>
Subject: logging stream creation
Date: Mon, 21 Jul 2008 09:57:58 -0700
Message-ID: <64F514C0-03F5-4F51-9572-9005FFD80A3F@comcast.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-relay2.palm.com (smtp-relay2.palm.com [64.28.152.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 420AD24362
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 18:58:00 +0200 (CEST)
Received: from [148.92.244.211] ([148.92.244.211])
	by mailhost01.palm.com (8.13.6+Sun/8.12.10) with ESMTP id
	m6LGvv9l019663
	for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2008 09:57:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I've just started looking at ALSA, and I have a couple questions that  
I hope will be pretty easy to answer.

I'd like to log stream creation as streams are brought up and shut  
down.  Should I use an I/O plugin for this?  Is there code I should  
start to look at for doing this.  Ideally I'd like to get a  
notification once streaming starts on a PCM and when it stops.

If I wanted to manipulate DMIX settings in response to streams being  
started and stopped, is it best to do this via a plugin (possibly the  
same one that I'd write for the stream monitoring, or from an external  
app that has a connection to the monitoring plug).

Finally is it possible to change the physical ALSA sink for a running  
PCM (for example if I have two devices, I start streaming on the first  
and decide in response to a user even that I need to stream to another  
sink).

Thank you!!

Nick
