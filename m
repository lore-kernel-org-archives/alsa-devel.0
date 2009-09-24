From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: AIC23 playback volume control not working
Date: Thu, 24 Sep 2009 19:25:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C5973@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id E6F631038BD
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 15:55:46 +0200 (CEST)
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8ODti3I014756
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2009 08:55:45 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8ODtgfd001406
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2009 19:25:43 +0530 (IST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to change the playback volume using amixer commands but
am not able to see any effect. Register writes are happening correctly
but no change in volume. Here is a short log:

root@omap3evm:~# amixer cset numid=1 0
tlv320aic23_write: reg=0x2, value=0x0
data[0]=0x4, data[1]=0x0
tlv320aic23_write: reg=0x3, value=0x0
data[0]=0x6, data[1]=0x0
numid=1,iface=MIXER,name='Digital Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=127,step=0
  : values=0,0
  | dBscale-min=-121.00dB,step=1.00dB,mute=0
root@omap3evm:~#
root@omap3evm:~#
root@omap3evm:~#
root@omap3evm:~#
root@omap3evm:~#
root@omap3evm:~# amixer cset numid=1 127
tlv320aic23_write: reg=0x2, value=0x7f
data[0]=0x4, data[1]=0x7f
tlv320aic23_write: reg=0x3, value=0x7f
data[0]=0x6, data[1]=0x7f
numid=1,iface=MIXER,name='Digital Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=127,step=0
  : values=127,127
  | dBscale-min=-121.00dB,step=1.00dB,mute=0
root@omap3evm:~#
root@omap3evm:~#

Any suggestions are appreciated.  

Regards,
Anuj Aggarwal
