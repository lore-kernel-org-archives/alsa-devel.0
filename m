From: Rohit Kumar <me.rohit@live.com>
Subject: Kernel crash at snd_ctl_find_numid+0x38/0x6c in kernel
	4.4
Date: Mon, 13 Feb 2017 18:17:42 +0000
Message-ID: <TY1PR0301MB10716F5C2D30274FC9DEDA7DED590@TY1PR0301MB1071.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SNT004-OMC1S35.hotmail.com (snt004-omc1s35.hotmail.com
 [65.55.90.46]) by alsa0.perex.cz (Postfix) with ESMTP id 7DE2A2669C8
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 19:17:46 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am getting NULL pointer dereference occasionally at snd_ctl_find_numid+0x38/0x6c in 4.4 kernel while accessing snd_kcontrol. The issue is reproduced ocassionally. Can anybody provide any pointer in fixing the issue. Below is the stack trace :

  2662.430298:   <2> PC is at snd_ctl_find_numid+0x38/0x6c
  2662.437819:   <2> LR is at snd_ctl_find_id+0x38/0xd8
  2662.662838:   <2> [<ffffff8008c4e35c>] snd_ctl_find_numid+0x38/0x6c
  2662.667513:   <2> [<ffffff8008c4e900>] snd_ctl_find_id+0x38/0xd8
  2662.673415:   <2> [<ffffff8008c4f488>] snd_ctl_elem_info+0x40/0x11c
  2662.678799:   <2> [<ffffff8008c4df5c>] snd_ctl_ioctl_compat+0x3f4/0x740
  2662.684644:   <2> [<ffffff800823477c>] compat_SyS_ioctl+0x124/0xd88


There is no specific usecase when the issue is observed. Sometimes issue occurs during bootup and sometimes during audio usecase.

 Any suggestion will be helpful.


Thanks,

Rohit
