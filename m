From: Patrick Lai <plai@codeaurora.org>
Subject: Compiler warning - overriding codec compress type
Date: Sun, 17 Apr 2011 23:37:34 -0700
Message-ID: <4DABDC2E.9080103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id E74131037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 08:37:27 +0200 (CEST)
Received: from [10.64.135.101] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 7728C10004BE
	for <alsa-devel@alsa-project.org>; Sun, 17 Apr 2011 23:37:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I got a compiler warning soc-core.c: In function 
'snd_soc_instantiate_cards' warning: 'compress_type' may be used 
uninitialized in this function. In reality, compress_type is defined as 
local variable in snd_soc_instantiate_card().

My kernel version is 2.6.38. Has the warning being addressed in 2.6.39 
or 2.6.40 patches? If not, after tracing through the code, I think the 
fix should look like the following:

list_for_each_entry(codec, &codec_list, list) {
                 if (codec->cache_init)
                         continue;
+               compress_type = 0;
                 /* check to see if we need to override the compress_type */
                 for (i = 0; i < card->num_configs; ++i) {
                         codec_conf = &card->codec_conf[i];

Please advise

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
