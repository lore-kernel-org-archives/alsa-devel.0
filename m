From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Question about rawmidi documentation
Date: Wed, 24 Jul 2002 00:31:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207240031.57343.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

In alsa-lib/src/rawmidi/rawmidi.c there are two functions :   
"snd_rawmidi_params", and  "snd_rawmidi_params_current". Both documented with 
very similar brief descriptions: "get parameters about rawmidi stream" and 
"get current parameters about rawmidi stream".

I suppose that the first function changes the parameters, and the second gets  
them. If not, How I can change the rawmidi parameters? Otherwise, the brief 
description should be fixed, because it goes to the generated doxygen docs, 
and the function names themselves are not very clear.


Regards,
Pedro



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
