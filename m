From: tomars <leijin.tang@access-company.com>
Subject: alsa conf file
Date: Fri, 14 Mar 2008 10:01:46 +0800
Message-ID: <1205460106.9834.23.camel@tomars-laptop>
References: <mailman.3111.1205405872.2095.alsa-devel@alsa-project.org>
Reply-To: leijin.tang@access-company.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3.access-company.com (mx5.access-company.com [12.7.175.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 65E6E243D2
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 03:01:57 +0100 (CET)
Received: from ussunex02.svl.access-company.com ([192.168.101.10])
	by mx5.access-company.com (8.13.8/8.13.8) with ESMTP id m2E21orv023858
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 19:01:55 -0700
In-Reply-To: <mailman.3111.1205405872.2095.alsa-devel@alsa-project.org>
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

I write a asound.conf file in the /etc/ , the detail is as follows.
pcm.hardware{
        type hw:0
        card 0
        device 0
}
pcm_slave.test {
        pcm "hardware"
        format S16_LE
        rate 44100
        channels 2
        period_time 20000
        buffer_time 80000
}
pcm.mix1{
        type dmix
        ipc_key 1235675
        ipc_key_add_uid true
        slave "test"
}

pcm.mix2{
        type dmix
        ipc_key 1235675
        ipc_key_add_uid true
        slave {
                pcm "hw:0"
                format S16_LE
                rate 44100
                channels 2
                period_time 20000
                buffer_time 80000
        }
}
pcm.!default {
        type plug
        slave.pcm mix2
		#slave.pcm mix1
}

when I use the slave.pcm mix2, the aplay works well. but if I select the slave.pcm mix1, the aplay gets the info:
ALSA lib pcm_direct.c:1462:(_snd_pcm_direct_get_slave_ipc_offset) Invalid type 'dmix' for slave PCM

I compare the definition of mix1 with the definition of mix2, I feel they have the identical meaning. so why does the mix2 get the error?
thank you!  
