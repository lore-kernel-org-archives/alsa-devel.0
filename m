From: Charles =?iso-8859-1?Q?Fl=E8che?= <charles.fleche@meletu.univ-valenciennes.fr>
Subject: How to send data trough rawmidi ?
Date: Sat, 6 Apr 2002 15:53:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020406155349.D522@pengouin.univ-valenciennes.fr>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA24531
	for <alsa-devel@alsa-project.org>; Sat, 6 Apr 2002 15:52:08 +0200
Received: from pengouin (lille-1-a7-62-147-2-206.dial.proxad.net [62.147.2.206])
	by postfix3-2.free.fr (Postfix) with ESMTP id 306C818093
	for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2002 15:51:54 +0200 (CEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello everybody !

I'm french, so I'll **TRY** to speak english correctly...

I'm new in C programming (in programming, in fact...) and I work on a=20
soft for speaking with an effect rack (alesis microverb IV) with sysex=20
trough rawmidi for saving my patches, remote control this unit, etc...

So, this is my problem  : I don't know how to send sysex through=20
rawmidi !! I'm using the snd_rawmidi_open and snd_rawmidi_write, but I=20
can't send anything !! Even the rawmidi.c test program from alsa-utils=20
don't work...

My soundcard is an Sound Blaster Live ! 1024 Player...

This is a piece of my source code :

/* START OF SOURCE */

#include <sys/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
	int prog;	//num of program
	int a;		//A parameter
	int b;		//B parameter
	int bank;	//bank number (0 =3D preset, 1 =3D user)
} pdb;

void affiche(unsigned char a[]) {
	int i=3D-1;
	=20
	printf("The next SySex have been sent trough RawMidi\n");
	=20
	=20
	while (a[i++] !=3D 0xF7) {
		printf("%x",a[i]);
		printf(" ");
	}
	printf("\n");
	printf("\n");
	=20
	return;
}

void entete(unsigned char mess[]) {

	/* start of SySex */
	mess[0]=3D0xf0;
	/* identification Alesis */
	mess[1]=3D0x00;
	mess[2]=3D0x00;
	mess[3]=3D0x0e;
	/*identification microverb IV*/
	mess[4]=3D0x12;
	/* MIDI channel (0x00 =3D omni) */
	mess[5]=3D0x00;
}

void sysex_store(unsigned char a[]) {

	// head of SySex
	entete(a);
	=20
	//SySex definition STORE
	a[6]=3D0x03;
	=20
	// EOX
	a[7]=3D0xF7;
}

void dump_store(snd_rawmidi_t *handle) {
	unsigned char sysex[8];
	ssize_t taille; //### VARIABLE A DECOMMENTER QUAND ON REACTIVE=20
L'ENVOIE DU SYSEX ###
	=20
	//creation du unsigned char
	sysex_store(sysex);
	=20
	//envoie du unsigned char
	snd_rawmidi_write(handle,sysex,taille);
	affiche(sysex);
}

int main (void) {
	=20
	snd_rawmidi_t *handle;

	snd_rawmidi_open(&handle, 0, 0, SND_RAWMIDI_OPEN_DUPLEX);	=20

	dump_store(handle);
	=20
	snd_rawmidi_close(handle);

	return 0;
}

/* END OF SOURCE */

Normally, this code create a "store the current program" message and=20
send it trough rawmidi... But it don't...

So, where is my error ?

Another small question : how can I force a pause in a program ? Is=20
there a function like [delay(10);] who make a pause of 10 miliseconds=20
in a execution ? I'll need to make a pause between to sysex later in=20
program...

Thanx for help a newbie !!

Charles Fl=E8che
