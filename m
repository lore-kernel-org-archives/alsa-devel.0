From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CVS: alsa-kernel/pci/ymfpci ymfpci.c,1.29,1.30
Date: Mon, 27 Oct 2003 12:15:16 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310271208280.23898-100000@studcom.urz.uni-halle.de>
References: <E1AD2DD-0003SF-00@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E1AD2DD-0003SF-00@sc8-pr-cvs1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Log Message:
> added auto-detection of joystick port.
> ...
> +	if (joystick_port[dev] == 1) {
> +		/* auto-detect */
> +		long p;
> +		for (p = 0x201; p <= 0x205; p++) {
> +			if (p == 0x203) continue;
> +			if ((joystick_res = request_region(p, 1, "YMFPCI gameport")) != NULL)
> +				break;
> +		}
> +		if (joystick_res)
> +			joystick_port[dev] = p;
> +	} else {
> ...

This auto-detection code doesn't set legacy_ctrl2, so the card
wouldn't actually use the port AFAICS.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
