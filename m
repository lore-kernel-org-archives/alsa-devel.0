From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: sequencer: handling non-registered parameter numbers....
Date: Sun, 15 Jun 2003 18:16:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EEC9BC6.5090603@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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

hello alsa gurus !

i have bought a peavey studiomix midi controller on ebay, and it sends=20
NRPN messages (non-registered parameter numbers). when i move a slider,=20
it sends the slider number encoded in 98 and 99 and the value in the=20
DATA ENTRY controllers 6 and 38. i would like to map these to ordinary=20
midi controllers, or better yet, get nrpn support into ardour.

how do i get nrpn controller values from the alsa sequencer without=20
having to parse the individual events and put them together by hand ?

grepping through alsa-lib, i found

static struct extra_event_list_t {
         int event;
         int (*decode)(snd_midi_event_t *dev, unsigned char *buf, int=20
len, snd_seq_event_t *ev);
} extra_event[] =3D {
         {SND_SEQ_EVENT_CONTROL14, extra_decode_ctrl14},
         /*{SND_SEQ_EVENT_NONREGPARAM, extra_decode_nrpn},*/
         /*{SND_SEQ_EVENT_REGPARAM, extra_decode_rpn},*/
};

which makes me think it might not yet be implemented....

any hints or fine manuals around ?

(disclaimer: i know absolutely *nothing* about the alsa seq code, my=20
level of understanding is matthias' example client.)

best,

j=F6rn

--=20
All Members shall refrain in their international relations from
the threat or use of force against the territorial integrity or
political independence of any state, or in any other manner
inconsistent with the Purposes of the United Nations.
	-- Charter of the United Nations, Article 2.4


J=F6rn Nettingsmeier
Kurf=FCrstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)






-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
