From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bug  in ens1371/ens1370 joystick driver
Date: Thu, 23 Oct 2003 09:14:04 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310230909020.295-100000@studcom.urz.uni-halle.de>
References: <200310222359.16532.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200310222359.16532.coding@reduz.com.ar>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juan Linietsky <coding@reduz.com.ar>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Juan Linietsky wrote:
> The ens1371 driver takes a joystick_port parameter with range 1..8
> but that same parameter is them put into a switch to detect io port
> values like 0x200, 0x208, etc. so the joystick will never be detected.

ens1370.c says:
MODULE_PARM(joystick_port, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
MODULE_PARM_DESC(joystick_port, "Joystick port address.");
MODULE_PARM_SYNTAX(joystick_port, SNDRV_ENABLED
	",allows:{{0},{0x200},{0x208},{0x210},{0x218}},dialog:list");

The range 1..8 means that it's possible to specify a parameter value
for each of the up to 8 cards (SNDRV_CARDS is defined as 8). The
parameter itself takes the correct values.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
