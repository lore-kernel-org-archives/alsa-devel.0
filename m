From: =?big5?B?Qy5MLiBUaWVuIC0gpdCp08Kn?= <cltien@cmedia.com.tw>
Subject: RE: CMI973, patch and alsa release
Date: Tue, 3 Feb 2004 01:32:49 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D363@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: Davodet Olivier <olivier.davodet@free.fr>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Is there a better way to do digital volume tuning without loss of =
cmpatability , especially for OSS applications? In the Azalia spec, PCM =
volume/mute is optional so there will be codecs without volume controls.

Sincerely,
ChenLi Tien

-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2004/2/2 [=ACP=B4=C1=A4@] =A4W=A4=C8 06:19
To:	Jaroslav Kysela
Cc:	Davodet Olivier; alsa-devel@lists.sourceforge.net
Subject:	Re: [Alsa-devel] CMI973, patch and alsa release
At Mon, 2 Feb 2004 09:06:37 +0100 (CET),
Jaroslav wrote:

well, let me clarify more the problems.

- the patch copies the whole audio data with the software
  attenuation.  we don't want this in the kernel context.
  this should be the job in the user-space, pereferrably in alsa-lib.

- the patch introduces float calculation.
  it's not allowed at all in the kernel code.


the control of ac97 mic and line sharing is a good point.
the similar thing can be implemented more easily by the alsa-lib's
hook plugin, though.


Takashi


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
