From: Mark Knecht <markknecht@comcast.net>
Subject: -Dplughw:0 & alsamixer...
Date: 24 Jul 2003 16:48:11 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1059090491.1874.4.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   Just checking. Should the volume levels I hear when using the command

aplay -Dplughw:0 -r 44100 data/wave/seque~10.wav

be controlled by alsmixer? alsaplayer is being, but this command is not,
at least right now.

   Also, on a multichannel card, how do I direct the above command to a
specific channel?

   If there's an explanation fit for a simpleton like me about the
difference between plughw and hw, please point me there so I can learn.

   Thanks in advance.

Cheers,
Mark



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
