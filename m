From: "Adrian McMenamin" <adrian@mcmen.demon.co.uk>
Subject: Re: Re: [linuxsh-dev] Hotplug firmware problems
Date: Thu, 6 Oct 2005 09:38:31 +0100 (BST)
Message-ID: <45978.217.150.108.178.1128587911.squirrel@newgolddream.dyndns.info>
References: <1128539845.3388.2.camel@localhost.localdomain>
    <Pine.HPX.4.33n.0510060850270.2481-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0510060850270.2481-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, Takashi Iwai <tiwai@suse.de>, linuxsh-dev@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 6 October, 2005 7:51 am, Clemens Ladisch wrote:
> Adrian McMenamin wrote:
>>     if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
>>         echo 1 > $SYSFS/$DEVPATH/loading
>>         cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
>>         echo 0 > $SYSFS/$DEVPATH/loading
>>     else
>>         echo -1 > $SYSFS/$DEVPATH/loading
>>     fi
>
> Try to add an echo to the else part; I guess $FIRMWARE_DIR/$FIRMWARE
> may not exist.


I tried this and no out put - but then I don't think (despite the message
in the log) that firmware.agent is being invoked but never executed.

Reading up about all this I wonder if it is a deeper problem - do I need
to worry about the hotplug methods in the kset? This is a bespoke device
(on the platform bus etc) so I am not sure what the kset being used is.

>
>
> HTH
> Clemens
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussion=
s,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
