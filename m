From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Disagreement about versions following CVS update
Date: Fri, 19 Aug 2005 15:11:39 -0600
Message-ID: <43064B0B.9080402@redfish-solutions.com>
References: <43063408.60402@redfish-solutions.com> <1124483804.25424.50.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1124483804.25424.50.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Fri, 2005-08-19 at 13:33 -0600, Philip Prindeville wrote:
>  
>
>>Stupid question:  did a version number get changed somewhere?  And if
>>so, what's the fix?  I did a:
>>
>>% make -C alsa-driver clean
>>
>>and a rebuild, but I'm still seeing these.  What did I miss?
>>    
>>
>
>Your kernel sources probably do not match the running kernel.
>
>Lee
>
>  
>


No, that's not the issue:

[root@media alsa]# make
...
checking for kernel version... 2.6.12-1.1372_FC3
...
checking for directory to store kernel modules... 
/lib/modules/2.6.12-1.1372_FC3/kernel/sound
...
make -C /lib/modules/2.6.12-1.1372_FC3/source 
SUBDIRS=/root/Downloads/alsa/alsa-driver 
O=/lib/modules/2.6.12-1.1372_FC3/build modules
...
install: cannot create regular file `/sbin/init.d/alsasound': No such 
file or directory
...

ALSA modules were successfully compiled.

...
/sbin/depmod -a -F /lib/modules/2.6.12-1.1372_FC3/source/System.map 
2.6.12-1.1372_FC3
...
[root@media alsa]# uname -a
Linux media 2.6.12-1.1372_FC3 #1 Fri Jul 15 00:55:23 EDT 2005 x86_64 
x86_64 x86_64 GNU/Linux
[root@media alsa]#



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
