From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000749]: Buzz from ALSA setup
Date: Sun, 26 Dec 2004 21:47:21 +0100
Message-ID: <51850f222240d82fc005e192034b1758@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 112C12B8
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2004 21:47:21 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=749> 
======================================================================
Reported By:                misnagid
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   749
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora FC3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-26-2004 15:37 CET
Last Modified:              12-26-2004 21:47 CET
======================================================================
Summary:                    Buzz from ALSA setup
Description: 
I get an almost constant buzz from speakers when I've tried to use ALSA. 
Have followed your directions from the online web page directions to the
letter.  Still buzz.
Have brought all sound levels up ising alsamixer and Kmix.  Of no help. 
Have tried everything I've seen about this problem.
OnBoard NVidia audio from Asus A7N8X-E Deluxe disabled.  Using emu10k1
driver for installed Creative Labs Audigy 2 soundcard. This is a brand new
successful in all other regards install of Fedora FC3.

======================================================================

----------------------------------------------------------------------
 misnagid - 12-26-04 21:43 
----------------------------------------------------------------------
When I run the "alsactl -F -f newtest.state restore", I get the following
coming out:

[root@ashkenazi jerry]# alsactl -F -f newtest.state restore
alsactl: set_control:797: warning: numid mismatch (58/61) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=58
alsactl: set_control:797: warning: numid mismatch (59/62) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59
alsactl: set_control:797: warning: numid mismatch (60/63) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=60
alsactl: set_control:797: warning: numid mismatch (61/64) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=61
alsactl: set_control:797: warning: numid mismatch (62/65) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=62
alsactl: set_control:797: warning: numid mismatch (63/66) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=63
alsactl: set_control:797: warning: numid mismatch (64/67) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=64
alsactl: set_control:797: warning: numid mismatch (65/68) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=65
alsactl: set_control:797: warning: numid mismatch (66/69) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=66
alsactl: set_control:797: warning: numid mismatch (67/70) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=67
alsactl: set_control:797: warning: numid mismatch (68/71) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=68
alsactl: set_control:797: warning: numid mismatch (69/72) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=69
alsactl: set_control:797: warning: numid mismatch (70/73) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=70
alsactl: set_control:797: warning: numid mismatch (71/74) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=71
alsactl: set_control:797: warning: numid mismatch (72/75) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=72
alsactl: set_control:797: warning: numid mismatch (73/76) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=73
alsactl: set_control:797: warning: numid mismatch (74/77) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=74
alsactl: set_control:797: warning: numid mismatch (75/78) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=75
alsactl: set_control:797: warning: numid mismatch (76/79) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=76
alsactl: set_control:797: warning: numid mismatch (77/80) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=77
alsactl: set_control:797: warning: numid mismatch (78/81) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=78
alsactl: set_control:797: warning: numid mismatch (79/82) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=79
alsactl: set_control:797: warning: numid mismatch (80/83) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=80
alsactl: set_control:797: warning: numid mismatch (81/84) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=81
alsactl: set_control:797: warning: numid mismatch (82/85) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=82
alsactl: set_control:797: warning: numid mismatch (83/86) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=83
alsactl: set_control:797: warning: numid mismatch (84/87) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=84
alsactl: set_control:797: warning: numid mismatch (85/88) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=85
alsactl: set_control:797: warning: numid mismatch (86/89) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=86
alsactl: set_control:797: warning: numid mismatch (87/90) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=87
alsactl: set_control:797: warning: numid mismatch (88/91) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=88
alsactl: set_control:797: warning: numid mismatch (89/92) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=89
alsactl: set_control:797: warning: numid mismatch (90/93) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=90
alsactl: set_control:797: warning: numid mismatch (91/94) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=91
alsactl: set_control:797: warning: numid mismatch (92/95) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=92
alsactl: set_control:797: warning: numid mismatch (93/96) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=93
alsactl: set_control:797: warning: numid mismatch (94/97) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=94
alsactl: set_control:797: warning: numid mismatch (95/98) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=95
alsactl: set_control:797: warning: numid mismatch (96/99) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=96
alsactl: set_control:797: warning: numid mismatch (97/100) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=97
alsactl: set_control:797: warning: numid mismatch (98/101) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=98
alsactl: set_control:797: warning: numid mismatch (99/102) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=99
alsactl: set_control:797: warning: numid mismatch (100/103) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=100
alsactl: set_control:797: warning: numid mismatch (101/104) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=101
alsactl: set_control:797: warning: numid mismatch (102/105) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=102
alsactl: set_control:797: warning: numid mismatch (103/106) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=103
alsactl: set_control:797: warning: numid mismatch (104/107) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=104
alsactl: set_control:797: warning: numid mismatch (105/108) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=105
alsactl: set_control:797: warning: numid mismatch (106/109) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=106
alsactl: set_control:797: warning: numid mismatch (107/110) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=107
alsactl: set_control:797: warning: numid mismatch (108/111) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=108
alsactl: set_control:797: warning: numid mismatch (109/112) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=109
alsactl: set_control:797: warning: numid mismatch (110/113) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=110
alsactl: set_control:797: warning: numid mismatch (111/114) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=111
alsactl: set_control:797: warning: numid mismatch (112/115) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=112
alsactl: set_control:797: warning: numid mismatch (113/116) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=113
alsactl: set_control:797: warning: numid mismatch (114/117) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=114
alsactl: set_control:797: warning: numid mismatch (115/118) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=115
alsactl: set_control:797: warning: numid mismatch (116/119) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=116
alsactl: set_control:797: warning: numid mismatch (117/120) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=117
alsactl: set_control:797: warning: numid mismatch (118/121) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=118
alsactl: set_control:797: warning: numid mismatch (119/122) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=119
alsactl: set_control:797: warning: numid mismatch (120/123) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=120
alsactl: set_control:797: warning: numid mismatch (121/124) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=121
alsactl: set_control:797: warning: numid mismatch (122/125) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=122
alsactl: set_control:797: warning: numid mismatch (123/126) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=123
alsactl: set_control:797: warning: numid mismatch (124/127) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=124
alsactl: set_control:797: warning: numid mismatch (125/128) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=125
alsactl: set_control:797: warning: numid mismatch (126/129) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=126
alsactl: set_control:797: warning: numid mismatch (127/130) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=127
alsactl: set_control:797: warning: numid mismatch (128/131) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=128
alsactl: set_control:797: warning: numid mismatch (129/132) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=129
alsactl: set_control:797: warning: numid mismatch (130/133) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=130
alsactl: set_control:797: warning: numid mismatch (131/134) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=131
alsactl: set_control:797: warning: numid mismatch (132/135) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=132
alsactl: set_control:797: warning: numid mismatch (133/136) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=133
alsactl: set_control:797: warning: numid mismatch (134/137) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=134
alsactl: set_control:797: warning: numid mismatch (135/138) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=135
alsactl: set_control:797: warning: numid mismatch (136/139) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=136
alsactl: set_control:797: warning: numid mismatch (137/140) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=137
alsactl: set_control:797: warning: numid mismatch (138/141) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=138
alsactl: set_control:797: warning: numid mismatch (139/142) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=139
alsactl: set_control:797: warning: numid mismatch (140/143) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=140
alsactl: set_control:797: warning: numid mismatch (141/144) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=141
alsactl: set_control:797: warning: numid mismatch (142/145) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=142
alsactl: set_control:797: warning: numid mismatch (143/146) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=143
alsactl: set_control:797: warning: numid mismatch (144/147) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=144
alsactl: set_control:797: warning: numid mismatch (145/148) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=145
alsactl: set_control:797: warning: numid mismatch (146/149) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=146
alsactl: set_control:797: warning: numid mismatch (147/150) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=147
alsactl: set_control:797: warning: numid mismatch (148/151) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=148
alsactl: set_control:797: warning: numid mismatch (149/152) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=149
alsactl: set_control:797: warning: numid mismatch (150/153) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=150
alsactl: set_control:797: warning: numid mismatch (151/154) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=151
alsactl: set_control:797: warning: numid mismatch (152/155) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=152
alsactl: set_control:797: warning: numid mismatch (153/156) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=153
alsactl: set_control:797: warning: numid mismatch (154/157) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154
alsactl: set_control:797: warning: numid mismatch (155/158) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=155
alsactl: set_control:797: warning: numid mismatch (156/159) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=156
alsactl: set_control:797: warning: numid mismatch (157/160) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=157
alsactl: set_control:797: warning: numid mismatch (158/161) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=158
alsactl: set_control:797: warning: numid mismatch (159/162) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=159
alsactl: set_control:797: warning: numid mismatch (160/163) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=160
alsactl: set_control:797: warning: numid mismatch (161/164) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=161
alsactl: set_control:797: warning: numid mismatch (162/165) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=162
alsactl: set_control:797: warning: numid mismatch (163/166) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=163
[root@ashkenazi jerry]#

----------------------------------------------------------------------
 pzad - 12-26-04 21:47 
----------------------------------------------------------------------
This is ok.

Still buzz ???

Try aplay again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 15:37 misnagid       New Issue                                    
12-26-04 15:37 misnagid       Distribution              => Fedora FC3      
12-26-04 15:37 misnagid       Kernel Version            => 2.6.9           
12-26-04 15:58 pzad           Note Added: 0002935                          
12-26-04 16:31 misnagid       Note Added: 0002936                          
12-26-04 16:44 misnagid       Note Added: 0002937                          
12-26-04 16:56 pzad           Note Added: 0002938                          
12-26-04 17:47 misnagid       Note Added: 0002939                          
12-26-04 18:07 misnagid       Note Added: 0002940                          
12-26-04 18:17 misnagid       Note Added: 0002942                          
12-26-04 18:38 misnagid       Note Added: 0002943                          
12-26-04 19:27 pzad           Note Added: 0002944                          
12-26-04 19:44 misnagid       File Added: test.state                       
12-26-04 19:44 misnagid       Note Added: 0002945                          
12-26-04 20:02 misnagid       Note Added: 0002946                          
12-26-04 20:09 misnagid       Note Added: 0002947                          
12-26-04 20:22 pzad           File Added: newtest.state                    
12-26-04 20:27 pzad           Note Added: 0002948                          
12-26-04 20:32 pzad           Note Added: 0002949                          
12-26-04 20:59 misnagid       Note Added: 0002950                          
12-26-04 21:11 misnagid       Note Added: 0002951                          
12-26-04 21:19 pzad           Note Added: 0002952                          
12-26-04 21:22 pzad           Note Added: 0002953                          
12-26-04 21:43 misnagid       Note Added: 0002954                          
12-26-04 21:47 pzad           Note Added: 0002955                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
