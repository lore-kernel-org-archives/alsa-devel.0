From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002231]: my system blocks 2 out of 4
	time when starting sound device at startup
Date: Tue, 4 Jul 2006 09:33:45 +0200
Message-ID: <f61a257d4631c955f3b1bb5bed8d236f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 63FCF18E
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Jul 2006 09:33:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2231> 
======================================================================
Reported By:                adeel
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2231
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               redhat
Kernel Version:             2.6.11-1.1369_FC4
======================================================================
Date Submitted:             06-25-2006 16:27 CEST
Last Modified:              07-04-2006 09:33 CEST
======================================================================
Summary:                    my system blocks 2 out of 4 time when starting sound
device at startup
Description: 
Hi guys,
	I sure need a bit of help. My system when starting the sound device got
crazy. I had fedora core 4. It starts the network, sound devices upfront
after its starts the kernel I think. There when it tries to start the
audio 2 out of 4 times it crashes. I had to then reset the system.

======================================================================

----------------------------------------------------------------------
 Raymond - 06-30-06 19:09 
----------------------------------------------------------------------
Your problem seem caused by snd_rawmidi

snd_rawmidi: disagrees about version of symbol snd_info_register
snd_rawmidi: Unknown symbol snd_info_register
snd_rawmidi: disagrees about version of symbol snd_seq_device_new
snd_rawmidi: Unknown symbol snd_seq_device_new
snd_rawmidi: disagrees about version of symbol snd_info_free_entry
snd_rawmidi: Unknown symbol snd_info_free_entry
snd_rawmidi: disagrees about version of symbol snd_unregister_oss_device
snd_rawmidi: Unknown symbol snd_unregister_oss_device
snd_rawmidi: Unknown symbol snd_verbose_printk
snd_rawmidi: disagrees about version of symbol snd_register_oss_device
snd_rawmidi: Unknown symbol snd_register_oss_device
snd_rawmidi: disagrees about version of symbol snd_ctl_register_ioctl
snd_rawmidi: Unknown symbol snd_ctl_register_ioctl
snd_rawmidi: disagrees about version of symbol snd_card_file_add
snd_rawmidi: Unknown symbol snd_card_file_add
snd_rawmidi: Unknown symbol snd_compat_kzalloc
snd_rawmidi: disagrees about version of symbol snd_iprintf
snd_rawmidi: Unknown symbol snd_iprintf
snd_rawmidi: disagrees about version of symbol snd_unregister_device
snd_rawmidi: Unknown symbol snd_unregister_device
snd_rawmidi: disagrees about version of symbol snd_device_new
snd_rawmidi: Unknown symbol snd_device_new
snd_rawmidi: disagrees about version of symbol snd_ctl_unregister_ioctl
snd_rawmidi: Unknown symbol snd_ctl_unregister_ioctl
snd_rawmidi: Unknown symbol snd_lookup_oss_minor_data
snd_rawmidi: Unknown symbol snd_lookup_minor_data
snd_rawmidi: disagrees about version of symbol snd_info_create_card_entry
snd_rawmidi: Unknown symbol snd_info_create_card_entry
snd_rawmidi: disagrees about version of symbol snd_device_free
snd_rawmidi: Unknown symbol snd_device_free
snd_rawmidi: disagrees about version of symbol snd_card_file_remove
snd_rawmidi: Unknown symbol snd_card_file_remove
snd_rawmidi: disagrees about version of symbol snd_info_unregister
snd_rawmidi: Unknown symbol snd_info_unregister
snd_rawmidi: disagrees about version of symbol snd_device_register
snd_rawmidi: Unknown symbol snd_device_register
snd_rawmidi: disagrees about version of symbol snd_register_device
snd_rawmidi: Unknown symbol snd_register_device

Your installation procedure is properly wrong. 

Why do you just replace snd*.*o ?

http://people.redhat.com/stransky/alsa/



----------------------------------------------------------------------
 adeel - 07-04-06 09:33 
----------------------------------------------------------------------
Thanks for the reply Raymond. you wrote
>Your problem seem caused by snd_rawmidi
>snd_rawmidi: disagrees about version of symbol snd_info_register
>snd_rawmidi: Unknown symbol snd_info_register .....

Sorry to say that but I did not understand "snd_rawmidi" messages.
I am not that good. Please can you tell me how can i fix the problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-25-06 16:27 adeel          New Issue                                    
06-25-06 16:27 adeel          File Added: output.txt                       
06-25-06 16:27 adeel          Distribution              => redhat          
06-25-06 16:27 adeel          Kernel Version            => 2.6.11-1.1369_FC4
06-29-06 09:31 adeel          Note Added: 0010644                          
06-30-06 17:49 adeel          Issue Monitored: jangutter                    
06-30-06 17:49 adeel          Issue Monitored: jan_k                       
06-30-06 17:49 adeel          Issue Monitored: jaredgreenwald                   

06-30-06 17:49 adeel          Issue Monitored: jaskjok                     
06-30-06 17:49 adeel          Issue Monitored: jb                          
06-30-06 17:49 adeel          Issue Monitored: jbarco                      
06-30-06 17:49 adeel          Issue Monitored: jbesiee                     
06-30-06 17:49 adeel          Issue Monitored: jbgordon                    
06-30-06 17:49 adeel          Note Added: 0010746                          
06-30-06 18:47 Raymond        Note Added: 0010751                          
06-30-06 18:57 Raymond        Note Edited: 0010751                         
06-30-06 19:09 Raymond        Note Edited: 0010751                         
07-04-06 09:33 adeel          Note Added: 0010817                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
