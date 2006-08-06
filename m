From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002287]: Segfaults all functions after
	snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t
	*) & val);
Date: Sun, 6 Aug 2006 02:31:33 +0200
Message-ID: <fb629d916d638d36eadb0ebea8615e6e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7C350169
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 02:31:33 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2287> 
======================================================================
Reported By:                cruiseoveride
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2287
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-16-2006 18:03 CEST
Last Modified:              08-06-2006 02:31 CEST
======================================================================
Summary:                    Segfaults all functions after
snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t *) & val);
Description: 
I am new to Alsa and am not happy at all at the state of documentation
available.
You guys seriously need to do something about this.

I have an M-Audio Audiophile Delta 192 (ICE1724) and I want to port
envy24control for this chip, However I first need to familiar myself with
the ALSA API. So I began by looking for simple examples on how to use ALSA
API and came accross the followinf prog (Attached file test.c).

The program compiles cleanly with gcc-4.1 and runs, however after it
prints out the ..."buffer size = 8192 frames"
It segfaults.

If you slash out line 104, it resolves the issue.

My question is,

Is there a bug in this function?
Code was obtained from http://www.linuxjournal.com/article/6735
======================================================================

----------------------------------------------------------------------
 cruiseoveride - 08-05-06 23:17 
----------------------------------------------------------------------
Wiring Info for M-Audio Audiophile 192 (AP192K) Rev-E
--------------------------------------------------------


AK4358 <=> Envy24HT
--------------------------------------------------------
AK4358 pin 19 (CCLK/SCL) <-> Envy24HT pin 51 (GPIO1)
AK4358 pin 20 (CDTI/SDA) <-> Envy24HT pin 53 (GPIO3)
AK4358 pin 21 (CSN/CAD1) <-> Envy24HT pin 56 (GPIO4)

AK4114 <=> Envy24HT
------------------------------------------------------- 
AK4114 pin 34 (CCLK) <-> Envy24HT pin 51 (GPIO1) 
AK4114 pin 33 (CDTI) <-> Envy24HT pin 53 (GPIO3) 
AK4114 pin 32 (CDTO) <-> Envy24HT pin 52 (GPIO2) 
AK4114 pin 35 (CSN) <-> Envy24HT pin 59 (GPIO7) 

AK5385A <=> Envy24HT
-------------------------------------------------------
AK5385 CKS0 does not appear to connect to Envy24HT
AK5385A DFS0 pin 18 <=> Envy24HT GPIO10 pin 77 
AK5385A DFS1 pin 20 <=> either Envy24HT pin 78 or 79, 

Can alsa write a driver now?

----------------------------------------------------------------------
 Raymond - 08-06-06 02:31 
----------------------------------------------------------------------
Do your AP192 EEPROM content as same as bobek's AP192 in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1646 ?

If you have study ice1724.c and datasheet of AK4358

3-wire mode or I2C mode of AK4358 is determined by control mode select pin
18

In I2C mode, CAD0 and CAD1 are used to compose the device address.


numid=1,iface=CARD,name='ICE1724 EEPROM'
  ; type=BYTES,access=r----,values=52
  :
values=0x36,0x32,0x14,0x12,0x13,0x02,0x68,0x80,0xf8,0xc3,0xba,0xff,0x7f,0x45
,0x00,0x00,0xb5,0x00,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x45,0x00,0x00,0x00,0xb5,0x00
,0x40,0x00,0xba,0xff,0x7f,0x00

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-06 18:03 cruiseoveride  New Issue                                    
07-16-06 18:03 cruiseoveride  File Added: test.c                           
07-16-06 20:38 cruiseoveride  Issue Monitored: cruiseoveride                    
07-17-06 02:44 Raymond        Note Added: 0011032                          
07-17-06 02:47 Raymond        Note Edited: 0011032                         
07-17-06 03:18 Raymond        Note Edited: 0011032                         
07-17-06 05:45 cruiseoveride  Note Added: 0011033                          
07-17-06 05:46 cruiseoveride  Note Edited: 0011033                         
07-17-06 07:31 Raymond        Note Added: 0011035                          
07-17-06 08:23 Raymond        Note Added: 0011036                          
07-17-06 08:26 Raymond        Note Edited: 0011036                         
07-17-06 14:48 cruiseoveride  Note Added: 0011039                          
07-17-06 14:59 cruiseoveride  Note Added: 0011040                          
07-17-06 16:07 Raymond        Note Added: 0011042                          
07-17-06 16:31 Raymond        Note Edited: 0011042                         
07-17-06 16:40 cruiseoveride  Note Added: 0011044                          
07-17-06 17:13 cruiseoveride  Note Added: 0011045                          
07-17-06 17:34 Raymond        Note Added: 0011046                          
07-17-06 17:56 cruiseoveride  Note Added: 0011047                          
07-18-06 07:44 Raymond        Note Added: 0011053                          
07-18-06 14:21 cruiseoveride  Note Added: 0011057                          
07-18-06 14:35 Raymond        Note Added: 0011060                          
07-19-06 02:52 cruiseoveride  Note Added: 0011075                          
07-19-06 03:27 Raymond        Note Added: 0011076                          
07-19-06 06:21 Raymond        Note Added: 0011080                          
07-19-06 17:43 cruiseoveride  Note Added: 0011090                          
07-19-06 17:50 cruiseoveride  File Added: chip.jpg                         
07-20-06 04:22 Raymond        Note Added: 0011107                          
07-20-06 05:01 Raymond        Note Edited: 0011107                         
07-20-06 08:05 cruiseoveride  Note Added: 0011112                          
07-20-06 08:19 Raymond        Note Added: 0011114                          
07-20-06 08:22 Raymond        Note Edited: 0011114                         
07-20-06 10:49 Raymond        Note Added: 0011116                          
07-20-06 15:52 cruiseoveride  Note Added: 0011127                          
07-20-06 16:09 Raymond        Note Added: 0011130                          
07-20-06 16:12 Raymond        Note Added: 0011131                          
07-20-06 16:35 cruiseoveride  Note Added: 0011132                          
07-20-06 16:39 cruiseoveride  Note Edited: 0011132                         
07-20-06 17:42 cruiseoveride  Note Added: 0011134                          
07-20-06 17:49 Raymond        Note Added: 0011135                          
07-20-06 17:55 Raymond        Note Edited: 0011135                         
07-20-06 19:30 Raymond        Note Added: 0011136                          
07-20-06 19:31 Raymond        Note Edited: 0011136                         
07-21-06 01:16 cruiseoveride  Note Added: 0011138                          
07-21-06 01:28 cruiseoveride  Note Added: 0011139                          
07-21-06 01:45 cruiseoveride  Note Added: 0011140                          
07-21-06 03:28 Raymond        Note Added: 0011141                          
07-21-06 20:23 cruiseoveride  Note Added: 0011155                          
07-22-06 02:13 Raymond        Note Added: 0011157                          
07-22-06 02:42 Raymond        Note Edited: 0011157                         
07-22-06 02:53 Raymond        Note Edited: 0011157                         
07-22-06 03:00 cruiseoveride  Note Added: 0011161                          
07-22-06 03:01 cruiseoveride  Note Edited: 0011161                         
07-22-06 04:12 Raymond        Note Added: 0011164                          
07-22-06 04:15 Raymond        Note Edited: 0011164                         
07-23-06 04:05 Raymond        Note Added: 0011179                          
07-23-06 06:26 cruiseoveride  Note Added: 0011181                          
07-23-06 06:41 Raymond        Note Added: 0011182                          
07-23-06 06:46 Raymond        Note Edited: 0011182                         
07-23-06 06:47 Raymond        Note Edited: 0011182                         
07-23-06 06:52 Raymond        Note Edited: 0011182                         
07-23-06 06:55 Raymond        Note Edited: 0011182                         
07-23-06 13:05 Raymond        Note Edited: 0011182                         
07-23-06 13:11 Raymond        Note Edited: 0011182                         
07-23-06 13:17 Raymond        Note Edited: 0011182                         
07-23-06 13:23 Raymond        Note Edited: 0011182                         
07-23-06 14:16 Raymond        Note Added: 0011187                          
07-23-06 14:20 Raymond        Note Edited: 0011187                         
07-23-06 15:24 Raymond        Note Edited: 0011187                         
07-23-06 17:23 rlrevell       Note Added: 0011190                          
07-23-06 17:39 Raymond        Note Added: 0011191                          
07-23-06 17:42 Raymond        Note Edited: 0011191                         
07-23-06 17:49 cruiseoveride  Note Added: 0011192                          
07-23-06 17:57 cruiseoveride  Note Added: 0011193                          
07-23-06 18:03 rlrevell       Note Added: 0011194                          
07-23-06 18:27 cruiseoveride  Note Added: 0011195                          
07-23-06 18:30 cruiseoveride  Note Edited: 0011195                         
07-23-06 18:33 cruiseoveride  Note Edited: 0011195                         
07-24-06 02:15 Raymond        Note Added: 0011206                          
07-24-06 02:27 Raymond        Note Edited: 0011206                         
07-24-06 02:28 Raymond        Note Edited: 0011206                         
07-24-06 07:12 Raymond        Note Edited: 0011206                         
07-24-06 07:48 Raymond        Note Edited: 0011206                         
07-25-06 18:02 Raymond        Note Added: 0011230                          
07-26-06 00:19 cruiseoveride  Note Added: 0011233                          
07-26-06 01:20 Raymond        Note Added: 0011234                          
07-26-06 01:27 Raymond        Note Edited: 0011234                         
07-26-06 01:31 Raymond        Note Edited: 0011234                         
07-26-06 01:33 Raymond        Note Edited: 0011234                         
07-26-06 04:30 cruiseoveride  Note Added: 0011237                          
07-26-06 04:39 cruiseoveride  File Added: 1724-envy24ht_nov2001.pdf             
      
07-26-06 04:41 cruiseoveride  Note Added: 0011238                          
07-26-06 04:47 Raymond        Note Added: 0011239                          
07-26-06 04:53 Raymond        Note Added: 0011240                          
07-26-06 05:17 Raymond        Note Edited: 0011240                         
07-26-06 06:22 Raymond        Note Added: 0011242                          
07-26-06 07:46 Raymond        Note Added: 0011243                          
07-26-06 07:55 Raymond        Note Edited: 0011243                         
07-26-06 15:42 cruiseoveride  Note Added: 0011248                          
07-26-06 23:59 cruiseoveride  Note Added: 0011251                          
07-27-06 00:15 cruiseoveride  Note Added: 0011252                          
07-27-06 00:50 cruiseoveride  Note Edited: 0011252                         
07-27-06 00:54 cruiseoveride  Note Added: 0011253                          
07-27-06 00:54 cruiseoveride  Note Edited: 0011253                         
07-27-06 00:57 rlrevell       Note Added: 0011254                          
07-27-06 01:00 cruiseoveride  Note Added: 0011255                          
07-27-06 01:03 rlrevell       Note Added: 0011256                          
07-27-06 04:43 Raymond        Note Added: 0011257                          
07-27-06 04:51 Raymond        Note Edited: 0011257                         
07-27-06 06:25 Raymond        Note Added: 0011258                          
07-27-06 06:28 Raymond        Note Edited: 0011258                         
07-27-06 06:29 Raymond        Note Edited: 0011258                         
07-27-06 06:36 Raymond        Note Edited: 0011258                         
07-27-06 06:38 cruiseoveride  Note Added: 0011259                          
07-27-06 06:44 Raymond        Note Edited: 0011258                         
07-27-06 07:15 rlrevell       Note Added: 0011260                          
07-27-06 10:24 Raymond        Note Added: 0011264                          
07-27-06 10:33 Raymond        Note Edited: 0011264                         
07-27-06 10:43 Raymond        Note Edited: 0011264                         
07-27-06 10:48 Raymond        Note Edited: 0011264                         
07-27-06 11:45 Raymond        Note Edited: 0011264                         
07-30-06 05:59 Raymond        Note Added: 0011315                          
07-30-06 06:26 cruiseoveride  Note Added: 0011316                          
08-01-06 01:26 rlrevell       Note Added: 0011356                          
08-01-06 01:42 cruiseoveride  Note Added: 0011360                          
08-01-06 01:49 rlrevell       Note Added: 0011361                          
08-01-06 03:22 Raymond        Note Added: 0011365                          
08-01-06 03:23 Raymond        Note Edited: 0011365                         
08-01-06 03:36 Raymond        Note Edited: 0011365                         
08-01-06 03:38 Raymond        Note Edited: 0011365                         
08-01-06 04:00 cruiseoveride  Note Added: 0011367                          
08-01-06 04:56 Raymond        Note Added: 0011369                          
08-01-06 05:04 Raymond        Note Edited: 0011369                         
08-01-06 05:11 Raymond        Note Edited: 0011369                         
08-01-06 05:52 Raymond        Note Edited: 0011369                         
08-01-06 06:51 Raymond        Note Edited: 0011369                         
08-01-06 07:08 Raymond        Note Edited: 0011369                         
08-01-06 07:17 Raymond        Note Edited: 0011369                         
08-01-06 07:21 Raymond        Note Edited: 0011369                         
08-01-06 07:33 Raymond        Note Edited: 0011369                         
08-01-06 09:07 Raymond        Note Edited: 0011369                         
08-05-06 02:10 Raymond        Note Added: 0011421                          
08-05-06 02:38 Raymond        Note Edited: 0011421                         
08-05-06 02:50 cruiseoveride  Note Added: 0011422                          
08-05-06 23:17 cruiseoveride  Note Added: 0011451                          
08-06-06 02:31 Raymond        Note Added: 0011453                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
