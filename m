From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Error compiling alsa-driver from sources
Date: Tue, 16 May 2006 12:52:58 -0300
Message-ID: <4469F55A.8060909@instant.com.br>
References: <4464A474.6070604@instant.com.br> <s5h3bfa3x9e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bfa3x9e.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>Juan Carlos Castro y Castro wrote:
>  
>
>>If I compile and install the HG version of alsa-lib while everything 
>>else is 1.0.11, will Bad Things happen?
>>    
>>
>No, it shouldn't.  alsa-lib API is backward compatible.
>
>But there were fixes and improvements in the driver and utils.  Better
>to update all things.
>  
>
I see that alsa-driver requires alsa-kernel, and finds it automatically 
if present in a sibling directory. That does not happen when installing 
the stable alsa-driver tarball.

Here's the error I got:

  CC [M]  /usr/src/hg/alsa-driver/pci/pdplus/pdplus.o
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6179: error: 
`PCI_VENDOR_ID_MARIAN' undeclared here (not in a function)
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6179: error: initializer 
element is not constant
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6179: error: (near 
initialization for `pdplus_ids[0].vendor')
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6180: error: 
`PCI_DEVICE_ID_MARIAN_PRODIF_PLUS' undeclared here (not in a function)
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6180: error: initializer 
element is not constant
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6180: error: (near 
initialization for `pdplus_ids[0].device')
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6183: error: initializer 
element is not constant
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6183: error: (near 
initialization for `pdplus_ids[0]')
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6184: error: initializer 
element is not constant
/usr/src/hg/alsa-driver/pci/pdplus/pdplus.c:6184: error: (near 
initialization for `pdplus_ids[1]')
make[5]: ** [/usr/src/hg/alsa-driver/pci/pdplus/pdplus.o] Erro 1
make[4]: ** [/usr/src/hg/alsa-driver/pci/pdplus] Erro 2
make[3]: ** [/usr/src/hg/alsa-driver/pci] Erro 2
make[2]: ** [_module_/usr/src/hg/alsa-driver] Erro 2
make[1]: ** [modules] Erro 2
make[1]: Leaving directory `/usr/src/linux-2.6.16-pom'
make: ** [compile] Erro 2



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
