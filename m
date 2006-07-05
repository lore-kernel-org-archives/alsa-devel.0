From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002257]: alsa-lib/test/timer -list
Date: Wed, 5 Jul 2006 16:14:37 +0200
Message-ID: <f540c1bdb7acb91a8bc8d9cde8baf21a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28170256
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Jul 2006 16:14:38 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2257> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2257
Category:                   timer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-05-2006 16:14 CEST
Last Modified:              07-05-2006 16:14 CEST
======================================================================
Summary:                    alsa-lib/test/timer -list
Description: 
Do pcm timer really support subdevice ?

The pcm device 0 of the sound cards has 32 subdevice.

timer -list 

The subdevice number seem not matched with the subdevice number of pcm.

It seem that playback and capture are mixed 


 cat /proc/asound/timers
G0: system timer : 10000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-2: PCM playback 0-0-2 : SLAVE
P0-0-3: PCM capture 0-0-3 : SLAVE
P0-0-4: PCM playback 0-0-4 : SLAVE
P0-0-5: PCM capture 0-0-5 : SLAVE
P0-0-6: PCM playback 0-0-6 : SLAVE
P0-0-7: PCM capture 0-0-7 : SLAVE
P0-0-8: PCM playback 0-0-8 : SLAVE
P0-0-9: PCM capture 0-0-9 : SLAVE
P0-0-10: PCM playback 0-0-10 : SLAVE
P0-0-11: PCM capture 0-0-11 : SLAVE
P0-0-12: PCM playback 0-0-12 : SLAVE
P0-0-13: PCM capture 0-0-13 : SLAVE
P0-0-14: PCM playback 0-0-14 : SLAVE
P0-0-15: PCM capture 0-0-15 : SLAVE
P0-0-16: PCM playback 0-0-16 : SLAVE
P0-0-17: PCM capture 0-0-17 : SLAVE
P0-0-18: PCM playback 0-0-18 : SLAVE
P0-0-19: PCM capture 0-0-19 : SLAVE
P0-0-20: PCM playback 0-0-20 : SLAVE
P0-0-21: PCM capture 0-0-21 : SLAVE
P0-0-22: PCM playback 0-0-22 : SLAVE
P0-0-23: PCM capture 0-0-23 : SLAVE
P0-0-24: PCM playback 0-0-24 : SLAVE
P0-0-25: PCM capture 0-0-25 : SLAVE
P0-0-26: PCM playback 0-0-26 : SLAVE
P0-0-27: PCM capture 0-0-27 : SLAVE
P0-0-28: PCM playback 0-0-28 : SLAVE
P0-0-29: PCM capture 0-0-29 : SLAVE
P0-0-30: PCM playback 0-0-30 : SLAVE
P0-0-31: PCM capture 0-0-31 : SLAVE
P0-0-32: PCM playback 0-0-32 : SLAVE
P0-0-33: PCM capture 0-0-33 : SLAVE
P0-0-34: PCM playback 0-0-34 : SLAVE
P0-0-35: PCM capture 0-0-35 : SLAVE
P0-0-36: PCM playback 0-0-36 : SLAVE
P0-0-37: PCM capture 0-0-37 : SLAVE
P0-0-38: PCM playback 0-0-38 : SLAVE
P0-0-39: PCM capture 0-0-39 : SLAVE
P0-0-40: PCM playback 0-0-40 : SLAVE
P0-0-41: PCM capture 0-0-41 : SLAVE
P0-0-42: PCM playback 0-0-42 : SLAVE
P0-0-43: PCM capture 0-0-43 : SLAVE
P0-0-44: PCM playback 0-0-44 : SLAVE
P0-0-45: PCM capture 0-0-45 : SLAVE
P0-0-46: PCM playback 0-0-46 : SLAVE
P0-0-47: PCM capture 0-0-47 : SLAVE
P0-0-48: PCM playback 0-0-48 : SLAVE
P0-0-49: PCM capture 0-0-49 : SLAVE
P0-0-50: PCM playback 0-0-50 : SLAVE
P0-0-51: PCM capture 0-0-51 : SLAVE
P0-0-52: PCM playback 0-0-52 : SLAVE
P0-0-53: PCM capture 0-0-53 : SLAVE
P0-0-54: PCM playback 0-0-54 : SLAVE
P0-0-55: PCM capture 0-0-55 : SLAVE
P0-0-56: PCM playback 0-0-56 : SLAVE
P0-0-57: PCM capture 0-0-57 : SLAVE
P0-0-58: PCM playback 0-0-58 : SLAVE
P0-0-59: PCM capture 0-0-59 : SLAVE
P0-0-60: PCM playback 0-0-60 : SLAVE
P0-0-61: PCM capture 0-0-61 : SLAVE
P0-0-62: PCM playback 0-0-62 : SLAVE
P0-0-63: PCM capture 0-0-63 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P0-2-0: PCM playback 0-2-0 : SLAVE
P0-2-2: PCM playback 0-2-2 : SLAVE
P0-2-4: PCM playback 0-2-4 : SLAVE
P0-2-6: PCM playback 0-2-6 : SLAVE
P0-2-8: PCM playback 0-2-8 : SLAVE
P0-2-10: PCM playback 0-2-10 : SLAVE
P0-2-12: PCM playback 0-2-12 : SLAVE
P0-2-14: PCM playback 0-2-14 : SLAVE
P0-2-16: PCM playback 0-2-16 : SLAVE
P0-2-18: PCM playback 0-2-18 : SLAVE
P0-2-20: PCM playback 0-2-20 : SLAVE
P0-2-22: PCM playback 0-2-22 : SLAVE
P0-2-24: PCM playback 0-2-24 : SLAVE
P0-2-26: PCM playback 0-2-26 : SLAVE
P0-2-28: PCM playback 0-2-28 : SLAVE
P0-2-30: PCM playback 0-2-30 : SLAVE
P0-3-0: PCM playback 0-3-0 : SLAVE
P0-3-2: PCM playback 0-3-2 : SLAVE
P0-3-4: PCM playback 0-3-4 : SLAVE
P0-3-6: PCM playback 0-3-6 : SLAVE
P0-3-8: PCM playback 0-3-8 : SLAVE
P0-3-10: PCM playback 0-3-10 : SLAVE
P0-3-12: PCM playback 0-3-12 : SLAVE
P0-3-14: PCM playback 0-3-14 : SLAVE
P0-3-16: PCM playback 0-3-16 : SLAVE
P0-3-18: PCM playback 0-3-18 : SLAVE
P0-3-20: PCM playback 0-3-20 : SLAVE
P0-3-22: PCM playback 0-3-22 : SLAVE
P0-3-24: PCM playback 0-3-24 : SLAVE
P0-3-26: PCM playback 0-3-26 : SLAVE
P0-3-28: PCM playback 0-3-28 : SLAVE
P0-3-30: PCM playback 0-3-30 : SLAVE
P0-3-32: PCM playback 0-3-32 : SLAVE
P0-3-34: PCM playback 0-3-34 : SLAVE
P0-3-36: PCM playback 0-3-36 : SLAVE
P0-3-38: PCM playback 0-3-38 : SLAVE
P0-3-40: PCM playback 0-3-40 : SLAVE
P0-3-42: PCM playback 0-3-42 : SLAVE
P0-3-44: PCM playback 0-3-44 : SLAVE
P0-3-46: PCM playback 0-3-46 : SLAVE
P0-3-48: PCM playback 0-3-48 : SLAVE
P0-3-50: PCM playback 0-3-50 : SLAVE
P0-3-52: PCM playback 0-3-52 : SLAVE
P0-3-54: PCM playback 0-3-54 : SLAVE
P0-3-56: PCM playback 0-3-56 : SLAVE
P0-3-58: PCM playback 0-3-58 : SLAVE
P0-3-60: PCM playback 0-3-60 : SLAVE
P0-3-62: PCM playback 0-3-62 : SLAVE
P0-3-64: PCM playback 0-3-64 : SLAVE
P0-3-66: PCM playback 0-3-66 : SLAVE
P0-3-68: PCM playback 0-3-68 : SLAVE
P0-3-70: PCM playback 0-3-70 : SLAVE
P0-3-72: PCM playback 0-3-72 : SLAVE
P0-3-74: PCM playback 0-3-74 : SLAVE
P0-3-76: PCM playback 0-3-76 : SLAVE
P0-3-78: PCM playback 0-3-78 : SLAVE
P0-3-80: PCM playback 0-3-80 : SLAVE
P0-3-82: PCM playback 0-3-82 : SLAVE
P0-3-84: PCM playback 0-3-84 : SLAVE
P0-3-86: PCM playback 0-3-86 : SLAVE
P0-3-88: PCM playback 0-3-88 : SLAVE
P0-3-90: PCM playback 0-3-90 : SLAVE
P0-3-92: PCM playback 0-3-92 : SLAVE
P0-3-94: PCM playback 0-3-94 : SLAVE
P0-3-96: PCM playback 0-3-96 : SLAVE
P0-3-98: PCM playback 0-3-98 : SLAVE
P0-3-100: PCM playback 0-3-100 : SLAVE
P0-3-102: PCM playback 0-3-102 : SLAVE
P0-3-104: PCM playback 0-3-104 : SLAVE
P0-3-106: PCM playback 0-3-106 : SLAVE
P0-3-108: PCM playback 0-3-108 : SLAVE
P0-3-110: PCM playback 0-3-110 : SLAVE
P0-3-112: PCM playback 0-3-112 : SLAVE
P0-3-114: PCM playback 0-3-114 : SLAVE
P0-3-116: PCM playback 0-3-116 : SLAVE
P0-3-118: PCM playback 0-3-118 : SLAVE
P0-3-120: PCM playback 0-3-120 : SLAVE
P0-3-122: PCM playback 0-3-122 : SLAVE
P0-3-124: PCM playback 0-3-124 : SLAVE
P0-3-126: PCM playback 0-3-126 : SLAVE

./timer list
Timer device: class 1, sclass 0, card -1, device 0, subdevice 0
Timer device: class 3, sclass 0, card 0, device 0, subdevice 0
Timer device: class 3, sclass 0, card 0, device 0, subdevice 1
Timer device: class 3, sclass 0, card 0, device 0, subdevice 2
Timer device: class 3, sclass 0, card 0, device 0, subdevice 3
Timer device: class 3, sclass 0, card 0, device 0, subdevice 4
Timer device: class 3, sclass 0, card 0, device 0, subdevice 5
Timer device: class 3, sclass 0, card 0, device 0, subdevice 6
Timer device: class 3, sclass 0, card 0, device 0, subdevice 7
Timer device: class 3, sclass 0, card 0, device 0, subdevice 8
Timer device: class 3, sclass 0, card 0, device 0, subdevice 9
Timer device: class 3, sclass 0, card 0, device 0, subdevice 10
Timer device: class 3, sclass 0, card 0, device 0, subdevice 11
Timer device: class 3, sclass 0, card 0, device 0, subdevice 12
Timer device: class 3, sclass 0, card 0, device 0, subdevice 13
Timer device: class 3, sclass 0, card 0, device 0, subdevice 14
Timer device: class 3, sclass 0, card 0, device 0, subdevice 15
Timer device: class 3, sclass 0, card 0, device 0, subdevice 16
Timer device: class 3, sclass 0, card 0, device 0, subdevice 17
Timer device: class 3, sclass 0, card 0, device 0, subdevice 18
Timer device: class 3, sclass 0, card 0, device 0, subdevice 19
Timer device: class 3, sclass 0, card 0, device 0, subdevice 20
Timer device: class 3, sclass 0, card 0, device 0, subdevice 21
Timer device: class 3, sclass 0, card 0, device 0, subdevice 22
Timer device: class 3, sclass 0, card 0, device 0, subdevice 23
Timer device: class 3, sclass 0, card 0, device 0, subdevice 24
Timer device: class 3, sclass 0, card 0, device 0, subdevice 25
Timer device: class 3, sclass 0, card 0, device 0, subdevice 26
Timer device: class 3, sclass 0, card 0, device 0, subdevice 27
Timer device: class 3, sclass 0, card 0, device 0, subdevice 28
Timer device: class 3, sclass 0, card 0, device 0, subdevice 29
Timer device: class 3, sclass 0, card 0, device 0, subdevice 30
Timer device: class 3, sclass 0, card 0, device 0, subdevice 31
Timer device: class 3, sclass 0, card 0, device 0, subdevice 32
Timer device: class 3, sclass 0, card 0, device 0, subdevice 33
Timer device: class 3, sclass 0, card 0, device 0, subdevice 34
Timer device: class 3, sclass 0, card 0, device 0, subdevice 35
Timer device: class 3, sclass 0, card 0, device 0, subdevice 36
Timer device: class 3, sclass 0, card 0, device 0, subdevice 37
Timer device: class 3, sclass 0, card 0, device 0, subdevice 38
Timer device: class 3, sclass 0, card 0, device 0, subdevice 39
Timer device: class 3, sclass 0, card 0, device 0, subdevice 40
Timer device: class 3, sclass 0, card 0, device 0, subdevice 41
Timer device: class 3, sclass 0, card 0, device 0, subdevice 42
Timer device: class 3, sclass 0, card 0, device 0, subdevice 43
Timer device: class 3, sclass 0, card 0, device 0, subdevice 44
Timer device: class 3, sclass 0, card 0, device 0, subdevice 45
Timer device: class 3, sclass 0, card 0, device 0, subdevice 46
Timer device: class 3, sclass 0, card 0, device 0, subdevice 47
Timer device: class 3, sclass 0, card 0, device 0, subdevice 48
Timer device: class 3, sclass 0, card 0, device 0, subdevice 49
Timer device: class 3, sclass 0, card 0, device 0, subdevice 50
Timer device: class 3, sclass 0, card 0, device 0, subdevice 51
Timer device: class 3, sclass 0, card 0, device 0, subdevice 52
Timer device: class 3, sclass 0, card 0, device 0, subdevice 53
Timer device: class 3, sclass 0, card 0, device 0, subdevice 54
Timer device: class 3, sclass 0, card 0, device 0, subdevice 55
Timer device: class 3, sclass 0, card 0, device 0, subdevice 56
Timer device: class 3, sclass 0, card 0, device 0, subdevice 57
Timer device: class 3, sclass 0, card 0, device 0, subdevice 58
Timer device: class 3, sclass 0, card 0, device 0, subdevice 59
Timer device: class 3, sclass 0, card 0, device 0, subdevice 60
Timer device: class 3, sclass 0, card 0, device 0, subdevice 61
Timer device: class 3, sclass 0, card 0, device 0, subdevice 62
Timer device: class 3, sclass 0, card 0, device 0, subdevice 63
Timer device: class 3, sclass 0, card 0, device 1, subdevice 0
Timer device: class 3, sclass 0, card 0, device 2, subdevice 0
Timer device: class 3, sclass 0, card 0, device 2, subdevice 2
Timer device: class 3, sclass 0, card 0, device 2, subdevice 4
Timer device: class 3, sclass 0, card 0, device 2, subdevice 6
Timer device: class 3, sclass 0, card 0, device 2, subdevice 8
Timer device: class 3, sclass 0, card 0, device 2, subdevice 10
Timer device: class 3, sclass 0, card 0, device 2, subdevice 12
Timer device: class 3, sclass 0, card 0, device 2, subdevice 14
Timer device: class 3, sclass 0, card 0, device 2, subdevice 16
Timer device: class 3, sclass 0, card 0, device 2, subdevice 18
Timer device: class 3, sclass 0, card 0, device 2, subdevice 20
Timer device: class 3, sclass 0, card 0, device 2, subdevice 22
Timer device: class 3, sclass 0, card 0, device 2, subdevice 24
Timer device: class 3, sclass 0, card 0, device 2, subdevice 26
Timer device: class 3, sclass 0, card 0, device 2, subdevice 28
Timer device: class 3, sclass 0, card 0, device 2, subdevice 30
Timer device: class 3, sclass 0, card 0, device 3, subdevice 0
Timer device: class 3, sclass 0, card 0, device 3, subdevice 2
Timer device: class 3, sclass 0, card 0, device 3, subdevice 4
Timer device: class 3, sclass 0, card 0, device 3, subdevice 6
Timer device: class 3, sclass 0, card 0, device 3, subdevice 8
Timer device: class 3, sclass 0, card 0, device 3, subdevice 10
Timer device: class 3, sclass 0, card 0, device 3, subdevice 12
Timer device: class 3, sclass 0, card 0, device 3, subdevice 14
Timer device: class 3, sclass 0, card 0, device 3, subdevice 16
Timer device: class 3, sclass 0, card 0, device 3, subdevice 18
Timer device: class 3, sclass 0, card 0, device 3, subdevice 20
Timer device: class 3, sclass 0, card 0, device 3, subdevice 22
Timer device: class 3, sclass 0, card 0, device 3, subdevice 24
Timer device: class 3, sclass 0, card 0, device 3, subdevice 26
Timer device: class 3, sclass 0, card 0, device 3, subdevice 28
Timer device: class 3, sclass 0, card 0, device 3, subdevice 30
Timer device: class 3, sclass 0, card 0, device 3, subdevice 32
Timer device: class 3, sclass 0, card 0, device 3, subdevice 34
Timer device: class 3, sclass 0, card 0, device 3, subdevice 36
Timer device: class 3, sclass 0, card 0, device 3, subdevice 38
Timer device: class 3, sclass 0, card 0, device 3, subdevice 40
Timer device: class 3, sclass 0, card 0, device 3, subdevice 42
Timer device: class 3, sclass 0, card 0, device 3, subdevice 44
Timer device: class 3, sclass 0, card 0, device 3, subdevice 46
Timer device: class 3, sclass 0, card 0, device 3, subdevice 48
Timer device: class 3, sclass 0, card 0, device 3, subdevice 50
Timer device: class 3, sclass 0, card 0, device 3, subdevice 52
Timer device: class 3, sclass 0, card 0, device 3, subdevice 54
Timer device: class 3, sclass 0, card 0, device 3, subdevice 56
Timer device: class 3, sclass 0, card 0, device 3, subdevice 58
Timer device: class 3, sclass 0, card 0, device 3, subdevice 60
Timer device: class 3, sclass 0, card 0, device 3, subdevice 62
Timer device: class 3, sclass 0, card 0, device 3, subdevice 64
Timer device: class 3, sclass 0, card 0, device 3, subdevice 66
Timer device: class 3, sclass 0, card 0, device 3, subdevice 68
Timer device: class 3, sclass 0, card 0, device 3, subdevice 70
Timer device: class 3, sclass 0, card 0, device 3, subdevice 72
Timer device: class 3, sclass 0, card 0, device 3, subdevice 74
Timer device: class 3, sclass 0, card 0, device 3, subdevice 76
Timer device: class 3, sclass 0, card 0, device 3, subdevice 78
Timer device: class 3, sclass 0, card 0, device 3, subdevice 80
Timer device: class 3, sclass 0, card 0, device 3, subdevice 82
Timer device: class 3, sclass 0, card 0, device 3, subdevice 84
Timer device: class 3, sclass 0, card 0, device 3, subdevice 86
Timer device: class 3, sclass 0, card 0, device 3, subdevice 88
Timer device: class 3, sclass 0, card 0, device 3, subdevice 90
Timer device: class 3, sclass 0, card 0, device 3, subdevice 92
Timer device: class 3, sclass 0, card 0, device 3, subdevice 94
Timer device: class 3, sclass 0, card 0, device 3, subdevice 96
Timer device: class 3, sclass 0, card 0, device 3, subdevice 98
Timer device: class 3, sclass 0, card 0, device 3, subdevice 100
Timer device: class 3, sclass 0, card 0, device 3, subdevice 102
Timer device: class 3, sclass 0, card 0, device 3, subdevice 104
Timer device: class 3, sclass 0, card 0, device 3, subdevice 106
Timer device: class 3, sclass 0, card 0, device 3, subdevice 108
Timer device: class 3, sclass 0, card 0, device 3, subdevice 110
Timer device: class 3, sclass 0, card 0, device 3, subdevice 112
Timer device: class 3, sclass 0, card 0, device 3, subdevice 114
Timer device: class 3, sclass 0, card 0, device 3, subdevice 116
Timer device: class 3, sclass 0, card 0, device 3, subdevice 118
Timer device: class 3, sclass 0, card 0, device 3, subdevice 120
Timer device: class 3, sclass 0, card 0, device 3, subdevice 122
Timer device: class 3, sclass 0, card 0, device 3, subdevice 124
Timer device: class 3, sclass 0, card 0, device 3, subdevice 126


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-05-06 16:14 Raymond        New Issue                                    
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
