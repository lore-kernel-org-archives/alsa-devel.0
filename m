From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: rawmidi problems
Date: Fri, 5 Jul 2002 18:57:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207051857.32862.plcl@telefonica.net>
References: <E17QW10-0005DE-00@bitone.upf.es>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17QW10-0005DE-00@bitone.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

El Vie 05 Jul 2002 18:33, Maarten de Boer escribió:
> add the flag -v to get verbose output and see what events you receive (this
> should be default behaviour i guess...)

It works! (and also with snd-usb-midi)
And I agree with you, -v option should be the default :)

$ ./rawmidi  -i hw:0,0 -v
Using:
Input: device hw:0,0
Output: NONE
Read midi in
Press ctrl-c to stop
read fe
read fe
read fe
read fe
read fe
read fe
read fe
read fe
read fe
Closing

Thanks,
Pedro


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
