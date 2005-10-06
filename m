From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [linuxsh-dev] Hotplug firmware problems
Date: Thu, 6 Oct 2005 08:51:19 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510060850270.2481-100000@studcom.urz.uni-halle.de>
References: <1128539845.3388.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1128539845.3388.2.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, linuxsh-dev@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
>     if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
>         echo 1 > $SYSFS/$DEVPATH/loading
>         cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
>         echo 0 > $SYSFS/$DEVPATH/loading
>     else
>         echo -1 > $SYSFS/$DEVPATH/loading
>     fi

Try to add an echo to the else part; I guess $FIRMWARE_DIR/$FIRMWARE
may not exist.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
