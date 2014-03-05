From: kaweka <kaweka@gazeta.pl>
Subject: UCM: How does its api relate to ALSA lib api?
Date: Wed, 5 Mar 2014 20:55:55 +0100
Message-ID: <72399ABC-B982-4FAF-BC5A-77E99175411F@gazeta.pl>
References: <E8B98BE78E55074F907D30F4F42883A603A9C97FD9E4@ABSEXCFWP01.gemalto.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6519326512B
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 20:55:58 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id my13so518785bkb.11
 for <alsa-devel@alsa-project.org>; Wed, 05 Mar 2014 11:55:58 -0800 (PST)
Received: from pc01-b.fritz.box (e178229106.adsl.alicedsl.de. [85.178.229.106])
 by mx.google.com with ESMTPSA id dj6sm6095935bkc.5.2014.03.05.11.55.56
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 05 Mar 2014 11:55:57 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

I am a newcomer if it goes to following topics: ALSA, audio in Linux, audio in embedded Linux.
However several years of experience in audio development on other platforms.
As next a development of audio applications in embedded Linux is the task.
However have few gaps in understanding of the audio system architecture.
It would be helpful to have answers to following questions.
For any hints lot of thanks in advance!

* There is well-known handshaking application-ALSA lib
  based on amonst others
snd_pcm_open
snd_pcm_hw_params_alloca
snd_pcm_hw_params_any
snd_pcm_hw_params_set_...
snd_pcm_hw_params
snd_pcm_hw_params_get_...
snd_pcm_hw_params_is_...
snd_pcm_hw_params_can_...
snd_pcm_close
* Does the UCM and its api complement the api
and handshaking as above. Or is it rather a question of replacement?
* If neither nor, how to describe best the relation between
UCM api and ALSA lib api?
* How does the entire handshaking application-audio system look like
  if to use ALSA and UCM api?
* An use case seems to be just a container for verb, device, modifier.
Is an use case introducing any functionality to be found
neither in verb, nor in device, nor in modifier?
* For what reason does the term / definition of use case exists at all.
Will verb, device, modifier not be enough?
* What is the difference between switching to other use case
and modifying a use case? Why not to switch to other use case
in situations where modifier is used?
* QoS api seems to introduce some redundancy.
If voice, or music, or other - this information can be gathered from use case.
A use case does already read voice, music, other!
Why is qos api necessary?

Best Regards
kaweka
