From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Tue, 17 Jan 2006 14:20:11 +0100
Message-ID: <1137504011.43ccef0ba85d6@webmail.uni-halle.de>
References: <2c746f620510180211hf803801mdda93f93aeae84c2@mail.gmail.com>
 <Pine.HPX.4.33n.0510181124030.2094-100000@studcom.urz.uni-halle.de>
 <2c746f620510182301j3419d000o857c2c72ef29880a@mail.gmail.com>
 <2c746f620510182303k782e04f2xa18b60cea49030a@mail.gmail.com>
 <1129746748.5203.1.camel@mindpipe>
 <2c746f620510191410v5032b3ebp673545e5958192ac@mail.gmail.com>
 <2c746f620601102330s337d7744r7b98dad75dbbf374@mail.gmail.com>
 <1136964861.27255.17.camel@mindpipe>
 <1137055672.43c617b8297f6@webmail.uni-halle.de>
 <2c746f620601162205x4bfbfefcl493cdb330dc4b5fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <2c746f620601162205x4bfbfefcl493cdb330dc4b5fd@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Eric Shattow wrote:
> +usb 3-1.6: new full speed USB device using ehci_hcd and address 5
> +ALSA /usr/src/modules/alsa-driver/usb/usbaudio.c:835: cannot submit
> datapipe for urb 0, err = -38

Enable EHCI full speed support in the kernel configuration, or connect it
to the computer without using a USB 2.0 hub.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
