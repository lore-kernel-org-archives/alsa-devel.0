From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: snd_ctl_open and snd_rawmidi_open conflict
Date: Wed, 2 Aug 2006 23:54:36 +0400
Message-ID: <70a871c80608021254q206ebc31jc8977c4d5e4e0891@mail.gmail.com>
References: <70a871c80607301752w16c1c014v40f574d17603f08d@mail.gmail.com>
	<s5h3bchabr4.wl%tiwai@suse.de>
	<70a871c80608011336w52e4d734v533eb650129a5564@mail.gmail.com>
	<s5hmzanhws3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9589_18091139.1154548476197"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmzanhws3.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_9589_18091139.1154548476197
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/2/06, Takashi Iwai <tiwai@suse.de> wrote:
> Does you device have really mulptile midi ports?
> Take a look at /proc/asound/card1/midi0, and how many ports exist
> there.

If I do not open ctl, I can open all ports - there are 4 ports
actually, it's ESI M4U

cat /proc/asound/card1/midi0 > card1_midi0.txt


Dmitry.

------=_Part_9589_18091139.1154548476197
Content-Type: text/plain; name=card1_midi0.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqe4bqll
Content-Disposition: attachment; filename="card1_midi0.txt"

RVNJLU00VQoKT3V0cHV0IDAKICBUeCBieXRlcyAgICAgOiAwCk91dHB1dCAxCiAgVHggYnl0ZXMg
ICAgIDogMApPdXRwdXQgMgogIFR4IGJ5dGVzICAgICA6IDAKT3V0cHV0IDMKICBUeCBieXRlcyAg
ICAgOiAwCklucHV0IDAKICBSeCBieXRlcyAgICAgOiAwCklucHV0IDEKICBSeCBieXRlcyAgICAg
OiAwCklucHV0IDIKICBSeCBieXRlcyAgICAgOiAwCklucHV0IDMKICBSeCBieXRlcyAgICAgOiAw
Cg==
------=_Part_9589_18091139.1154548476197
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_Part_9589_18091139.1154548476197
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_9589_18091139.1154548476197--
