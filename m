From: "freeman.liu" <freeman.liu@sun.com>
Subject: A bug in intel8x0.c
Date: Fri, 16 Jan 2004 11:31:46 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40075B22.6060208@sun.com>
References: <3FE07BE6.5010100@superbug.demon.co.uk> <Pine.LNX.4.58.0312171653350.8959@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312171653350.8959@pnote.perex-int.cz>
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

Hi, guy,
   
    I'm sure I found a bug in intel8x0.c.
   
    At the end of the function snd_intel8x0_codec_semaphore. If we 
couldn't get the semaphore in
1 ms, we'll reset the register and return EBUSY. But to reset the 
register, we should do a
    iaputword ( chip, 0, 0 ), according to the datasheet, write any 
value the this register will reset the
register.
    But in the code, what we did is iagetword ( chip, 0 ). This bug 
hadn't be exclosed because this code
path had never been reached, for the semaphore error often means a 
hardware error, which is very
rare.
    So, is there anybody who can modify this ?


    Freeman




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
