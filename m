From: Juan Linietsky <coding@reduz.com.ar> (by way of Juan Linietsky <coding@reduz.com.ar>)
Subject: Re: bug  in ens1371/ens1370 joystick driver
Date: Thu, 23 Oct 2003 16:23:26 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310231623.26007.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 23 October 2003 04:14, you wrote:
> Juan Linietsky wrote:
> > The ens1371 driver takes a joystick_port parameter with range 1..8
> > but that same parameter is them put into a switch to detect io port
> > values like 0x200, 0x208, etc. so the joystick will never be detected.
>
> ens1370.c says:
> MODULE_PARM(joystick_port, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
> MODULE_PARM_DESC(joystick_port, "Joystick port address.");
> MODULE_PARM_SYNTAX(joystick_port, SNDRV_ENABLED
> 	",allows:{{0},{0x200},{0x208},{0x210},{0x218}},dialog:list");
>
> The range 1..8 means that it's possible to specify a parameter value
> for each of the up to 8 cards (SNDRV_CARDS is defined as 8). The
> parameter itself takes the correct values.
>
>
> Regards,
> Clemens

this is still not very helpful, as modinfo -p only returns:

joystick_port int array (min = 1, max = 8), description "Joystick port
address."

how are you supposed to know that you can only enter 0x200,0x208,etc?
Specially when in the OSS driver you do:

modprobe es1371 joystick=1

and it works flawlessly


Regards

Juan Linietsky



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
