From: "David Shust" <dshust@bemail.org>
Subject: YMF753 AC '97 Module Options
Date: Tue, 24 Sep 2002 10:44:58 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209241744.g8OHiw010210@mail18.bigmailbox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: binary
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Takashi Iwai wrote
>the patch looks good except for the module options for spdif.
>since ac97_codec is a generic module, it's better to avoid
>such device specific options.  isn't it detectable?

If the Yamaha YMF753 spec provided a way to autodetect which pin was being used for S/PDIF ouput, I'd use it.

The alternative to providing a module parameter via insmod would be to provide a mixer control, where one would have the choice of disabling S/PDIF output, or selecting pin 43 or 48. My instincts told me that it made more sense having this as a module parameter, as once one has determined which pin is being used, why would one ever change that value. I felt the same about the parameter for adding the delay after DAC startup in order to avoid missing audio. I could make both items mixer controls if both Jaroslav and Takashi feel it is better. Could you both please respond?

Regards,
David Shust


------------------------------------------------------------
Free, BeOS-friendly email accounts: http://BeMail.org/
BeOS News and Community: http://www.BeGroovy.com/


---------------------------------------------------------------------
Express yourself with a super cool email address from BigMailBox.com.
Hundreds of choices. It's free!
http://www.bigmailbox.com
---------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
