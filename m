From: Marcus Andersson <054185595@telia.com>
Subject: HDSP midi debugged
Date: Fri, 27 Jun 2003 18:20:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EFC6EB7.1314236D@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have found the reason for the loss of input bytes on the hdsp midi,
but I don't know how to correctly fix it.

The function snd_hdsp_midi_input_trigger() is repeatedly called with
up==true. This results in the input being flushed. Definitely not good.

Can someone tell me what this function is supposed to do? What does 'up'
mean? Why is the input flushed here?

Marcus


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
