From: Juan Linietsky <coding@reduz.com.ar>
Subject: bug  in ens1371/ens1370 joystick driver
Date: Wed, 22 Oct 2003 23:59:16 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310222359.16532.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

I apologize for not being able to send patches, but I dont know
how to proper fix this.

The ens1371 driver takes a joystick_port parameter with range 1..8
but that same parameter is them put into a switch to detect io port
values like 0x200, 0x208, etc. so the joystick will never be detected.
I somewhat fixed this myself by forcing 0x200 as parameter
and it worked well afterwards.

I hope this report is of any help
regards

Juan Linietsky



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
