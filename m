From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?Q?[ALSA_-_driver_0001889]:_ESI_Juli@_on_1.0.10_bad_sound_=C6?=
 =?iso-8859-1?Q?=C5_44100_(no_high_freq),_but_on_1.0.10rc2_everything_OK!?=
Date: Sat, 4 Mar 2006 18:55:09 +0100
Message-ID: <c356afbbc8bb4034f981871a6010f3bd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CB0F3178
	for <alsa-devel@alsa-project.org>; Sat,  4 Mar 2006 18:55:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1889> 
======================================================================
Reported By:                CannabiASM
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1889
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-04-2006 08:14 CET
Last Modified:              03-04-2006 18:55 CET
======================================================================
Summary:                    ESI Juli@ on 1.0.10 bad sound фе 44100 (no high
freq), but on 1.0.10rc2 everything OK!
Description: 
На версии alsa-drivers-1.0.10rc2 с чистотой звука всё отлично: чистый,
детальный, пространственный. Пробовал 1.0.10 и 1.0.11rc3 - звук в 44100
сухой, глухой, бубнящий, практически без высоких частот...
Если использовать jack (jackd -R -d alsa -d "hw:1" -D -p 256 -r 192000 -H
-M) с чистотой звука всё нормально (в 192000 даже пространственнее звучит
чем 1.0.10rc2), но он со щелчками, по видимому из-за передискретизации
44100 в 192000. Пока откатил назад на 1.0.10rc2.
От версии остальных пакетов (libs, oss, tools...) не зависит.
Проверялось на 2.6.14 и 2.6.15.4 ядрах.
======================================================================

----------------------------------------------------------------------
 CannabiASM - 03-04-06 18:55 
----------------------------------------------------------------------
Проверил звук на 1.0.10rc3 - тоже всё впорядке. По видимому, что-то
нарушено в связи с добавлением регуляторов громкости.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-06 08:14 CannabiASM     New Issue                                    
03-04-06 18:55 CannabiASM     Note Added: 0008351                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
