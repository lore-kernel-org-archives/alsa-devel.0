From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: alsa-lib resamplers broken.
Date: Wed, 17 Dec 2003 15:53:10 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE07BE6.5010100@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

If I use the "front" device name, and select a rate of 48000, I get 
sound output. (snd-intel8x0)
If I use the "front" device name, and select a rate of 44100, It replies 
saying 44100 is not availiable, try 48000 instead!

As the "front" device is a plug device, alsa-lib should automatically 
resample 44100 to 48000 instead of rejecting 44100.

This is only a problem when the alsa-lib resamplers are needed.
If the card hardware supports 48000 and 44100, it works fine, but as the 
snd-intel8x0 only supports 1 rate, the alsa-lib resamplers should act 
but fail.

Please help

Cheers
James


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
