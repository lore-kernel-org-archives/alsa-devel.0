From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: How do I make -D hw:0,1 default?
Date: Tue, 3 Jun 2003 11:34:14 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGOEBBCGAB.mknecht@controlnet.com>
References: <NDBBLGIKBJENLAMOLFHGEEAJCGAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGEEAJCGAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> .asoundrc from Alsa site:
>
>         pcm.via82xx {
>            type hw
>            card 0
>         }
>
>         ctl.via82xx {
>            type hw
>            card 0
>         }
>
> Maybe I need to include the ',1' interface somehow? How would I do that?
>
> Thanks,
> Mark

Would this be correct?
(Info taken from
http://alsa.opensrc.org/index.php?page=.asoundrc
)

         pcm.via82xx {
            type hw
            card 0
            device 0
            subdevice 1
         }

         ctl.via82xx {
            type hw
            card 0
            device 0
            subdevice 1
         }

Or do I need to give it a different name and call it specifically for every
application that needs sound? This is the part I cannot seem to find info
on....

Thanks,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
