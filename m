From: christopher cuse <ccuse@tiscali.fr>
Subject: audio format TYPE II and TYPE III descriptor support
Date: 09 May 2003 09:22:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052464949.2144.6.camel@drs0.manchotnetworks.net>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: alsa-user-list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Good Day,

the following is a snip from 

/alsa-driver-0.9.3a/alsa-kernel/usb/usbaudio.c

       /* FIXME: needed support for TYPE II and III */
        if (format_type != USB_FORMAT_TYPE_I) {
                snd_printd(KERN_INFO "%d:%u:%d : format type %d is not
supported yet\n",
                           dev->devnum, iface_no, altno, format_type);
                return -1;
        }


If a usb card has TYPE II or TYPE III, is there a work around?


Many Thanks

Christopher CUSE



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
