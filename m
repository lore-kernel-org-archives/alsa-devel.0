From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: my first usb-midi experiment ends with segmentation fault
Date: Tue, 30 Jul 2002 17:08:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207301708.07066.plcl@telefonica.net>
References: <20020728213924.GA522@tuba.home> <3D469011.855453A7@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D469011.855453A7@ladisch.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

El Mar 30 Jul 2002 15:09, Clemens Ladisch escribió:
> -		if (port < 0)
> +		if (port < 0) {
> +			snd_printk(KERN_ERR "cannot create port (error code %d)\n", err);
>  			return port;

I think that you mean:
			snd_printk(KERN_ERR "cannot create port (error code %d)\n", port);

Right? :)

Pedro.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
