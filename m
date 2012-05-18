From: Sebastien LEDUC <sebastien.leduc@stericsson.com>
Subject: Question on Dynamic PCM
Date: Fri, 18 May 2012 16:02:09 +0200
Message-ID: <A3217089E06965468FCEC60ADC3A8F925C16AA7EF8@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 51826103F94
	for <Alsa-devel@alsa-project.org>;
	Fri, 18 May 2012 16:02:25 +0200 (CEST)
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.16.71])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id 2A5A461
	for <Alsa-devel@alsa-project.org>; Fri, 18 May 2012 14:01:53 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 551BD57
	for <Alsa-devel@alsa-project.org>; Fri, 18 May 2012 11:33:20 +0000 (GMT)
Received: from exdcvycastm004.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm004", Issuer "exdcvycastm004" (not verified))
	by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 5392F24C07C
	for <Alsa-devel@alsa-project.org>;
	Fri, 18 May 2012 16:02:04 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In commit "ASoC: dapm: Add API call to query valid DAPM paths<http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=commit;h=ec2e3031b65f23f66840b5c89c4b83076831a435>" , the signature of the functions is_connected_input_ep / is_connected_output_ep has been modified so that the 2 functions now fill list of connected DAPM widgets.

What I don't understand is why the way widgets are added is not symmetric between the two:

In function is_connected_output_ep:
-----------------------------------------------

 list_for_each_entry(path, &widget->sinks, list_source) {
                ...
                err = dapm_list_add_widget(list, path->sink);
                ...
}

In function is_connected_input_ep:
---------------------------------------------

list_for_each_entry(path, &widget->sources, list_sink) {
...
                err = dapm_list_add_widget(list, path->sink);
}


I would have expected to have for the latter:
err = dapm_list_add_widget(list, path->source);

regards,
Sebastien Le Duc
