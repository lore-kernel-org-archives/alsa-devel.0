From: "Sheng \(Sean\) Liu" <shengl@uci.edu>
Subject: When to start the capture device?
Date: Wed, 19 Sep 2007 16:17:55 -0700
Message-ID: <005101c7fb13$511e5040$aea4c380@dream.eng.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay3.es.uci.edu (relay3.es.uci.edu [128.200.80.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 979BF245B3
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 01:17:04 +0200 (CEST)
Received: from agent9 (agent9.eng.uci.edu [128.195.164.174])
	(authenticated bits=0)
	by relay3.es.uci.edu (8.13.1/8.13.1) with ESMTP id l8JNGxh6029034
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2007 16:17:02 -0700
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

Hello everyone,
 
I am using ALSA to capture sound from a micrphone. I need to know when the
capture device starts. In Paul Davis' Tutorial, he mentioned two approaches.
But, I have questions on each of them.
  

When to start the device 

When you open the audio interface, ALSA ensures that it is not active - no
data is being moved to or from its external connectors. Presumably, at some
point you want this data transfer to begin. There are several options for
how to make this happen. 


1. The control point here the start threshold, which defines the number of
frames of space/data necessary to start the device automatically. If set to
some value other than zero for playback, it is necessary to prefill the
playback buffer before the device will start. If set to zero, the first data
written to the device (or first attempt to read from a capture stream) will
start the device. 
 
My question: what does he means on " If set to zero"? Does anyone know which
parameter of which API should be set to zero?

2. You can also start the device explicitly using snd_pcm_start, but this
requires buffer prefilling in the case of the playback stream. If you
attempt to start the stream without doing this, you will get -EPIPE as a
return code, indicating that there is no data waiting to deliver to the
playback hardware buffer.
 
My question: Is there anything to be done before calling snd_pcm_start in
the case of capturing stream? If there is, what are they?
 
 
Thanks in advance,
 
Sheng
