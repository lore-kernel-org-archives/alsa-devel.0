From: Andrei Boros <andrei@srr.ro>
Subject: Re: Opti92x-ad1848 won't take Opti924 card
Date: Mon, 29 Sep 2003 09:39:09 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F77D38D.150C3BD8@srr.ro>
References: <Pine.HPX.4.33n.0309230903041.1405-100000@studcom.urz.uni-halle.de>
	  <3F7001AF.C13AC3CC@srr.ro> <Pine.LNX.4.53.0309231107220.10953@pnote.perex-int.cz>
	 <3F717ED7.15306C51@srr.ro> <Pine.LNX.4.53.0309251238520.1362@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> > ---------------------------------------------------------------
> > Card 1 'OPT0924:OPTi Audio 16' PnP version 1.0
> >   Logical device 0 'OPT0000:Pro Audio 16'
> 
> This looks ok. It seems that you don't have compiled the ISA PnP support
> for the module or something is broken. Could you check, if the snd- module
> has references to pnp_* functions? (nm snd-opti92x-ad1848.o  | grep pnp_)
> 
>                                                 Jaroslav
> 
I compiled the drivers with ./configure --with-isapnp=yes

And : 

gate:/lib/modules/2.2.24/misc# nm snd-opti92x-ad1848.o | grep pnp
00000120 ? __module_generic_string_info_parm_isapnp
00000344 r __module_isapnp_card_size
00000268 d __module_isapnp_card_table
000001a0 ? __module_parm_desc_isapnp
00000174 ? __module_parm_isapnp
0000001c r __module_pnp_card_device_size
00000110 d __module_pnp_card_device_table
00000008 d isapnp
         U isapnp_resource_change_R09b965af
000001c0 d opti9xx_pnpc_driver
         U pnp_activate_dev_R34290b72
         U pnp_init_resource_table_R16084899
         U pnp_manual_config_dev_R9cc42c96
         U pnp_register_card_driver_R1c33083c
         U pnp_request_card_device_R75d4bc7a
         U pnp_unregister_card_driver_R390814a8
000006a0 t snd_card_opti9xx_pnp
00000e94 t snd_opti9xx_pnp_remove
0000002c d snd_opti9xx_pnpids
000001f0 d snd_opti9xx_pnpids_old



-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
