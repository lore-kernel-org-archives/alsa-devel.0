From: Charles =?iso-8859-1?Q?Fl=E8che?= <charles.fleche@meletu.univ-valenciennes.fr>
Subject: Re: assertion problem in rawmidi.c line 301
Date: Fri, 10 May 2002 19:09:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020510190950.E1653@pengouin.univ-valenciennes.fr>
References: <20020510180003.A1344@pengouin.univ-valenciennes.fr>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix1-2.free.fr (postfix1-2.free.fr [213.228.0.130])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA17443
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 19:08:26 +0200
In-Reply-To: <20020510180003.A1344@pengouin.univ-valenciennes.fr>; from charles.fleche@univ-valenciennes.fr on Fri, May 10, 2002 at 18:00:03 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Charles =?iso-8859-1?Q?Fl=E8che?= <charles.fleche@univ-valenciennes.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

OK, I'm stupid... Sorry for using the devel-list for such a fu.....=20
thing.

Charles



On 2002.05.10 18:00 Charles Fl=E8che wrote:
> Who ! What's a problem !
>=20
> This is my source code :
>=20
> /* START OF SOURCE */
>=20
> * tests midi
> 	Utilisation de l'API rawmidi
> 	On passe pars l'API rawmidi
> 	 	TEST 1 : dump store
> 	TEST 2 : dump edit buffer (programme 0, tous les param=EAtres =E0 0)
> 	TEST 3 : dump all data
> 	TEST 4 : request all data (dump du message et reception du=20
> sysex en retour)
> 	TEST 5 : program change vers 00
> */
>=20
> #include <stdio.h>
> #include <unistd.h>
> #include <time.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <alsa/asoundlib.h>
>=20
>=20
> void store(snd_rawmidi_t *handle) {
>=20
> 	snd_rawmidi_write (handle, "\xf0\x00\x00\x0e\x12\x00\x03\xF7",=20
> 8);
> 	snd_rawmidi_drain(handle);
> }
>=20
> void deb(int fd) {
> 	// pour se rapprocher de la realite future du programme, un=20
> tableau de unsigned char est passe =E0 write
> 	 	unsigned char=20
> sysex[]=3D"\xF0\x00\x00\x0E\x12\x00\x00\x00\x00\x00\x00\xF7";
> 	 	write (fd,sysex,12);
> }
>=20
> void dad(snd_rawmidi_t *handle) {
> 	// pour se rapprocher de la realite future du programme, un=20
> tableau de unsigned char est passe =E0 write
> 	int i;
> 	int flag;
> 	struct timespec *delay;
> 	unsigned char=20
> sysex[]=3D"\xF0\x00\x00\x0E\x12\x00\x01\x03\x00\x00\x24\x50\x01\x3F\x30=
\x01\x50\x1E\x01\x32\x20\x01\x25\x3F\x01\x44\x12\x01\x5A\x7F\x01\x0F\x57\=
x01\x38\x1E\x01\x35\x60\x01\x3D\x4F\x01\x4E\x11\x01\x2A\x4B\x01\x44\x60\x=
01\x40\x55\x01\x32\x61\x01\x19\x75\x01\x63\x73\x01\x18\x54\x01\x3C\x50\x0=
1\x2A\x54\x01\x21\x55\x01\x34\x22\x01\x30\x66\x01\x2B\x46\x01\x15\x6F\x01=
\x31\x4A\x01\x40\x7F\x01\x51\x47\x01\x03\x25\x01\x11\x0F\x01\x02\x0F\x01\=
x08\x24\x01\x0E\x0A\x01\x03\x1E\x01\x05\x1E\x01\x08\x14\x01\x19\x0F\x01\x=
01\x7D\x01\x07\x1E\x01\x04\x19\x01\x02\x5B\x01\x04\x0F\x01\x03\x15\x01\x0=
2\x47\x01\x03\x19\x01\x06\x7D\x01\x05\x64\x01\x0A\x4B\x01\x02\x00\x01\x30=
\x00\x01\x55\x00\x01\x46\x10\x01\x1E\x00\x01\x0D\x1E\x01\x00\x00\x01\x00\=
x63\x01\x64\x1C\x01\x66\x07\x01\x1E\x46\x01\x46\x1E\x01\x2A\x3A\x01\x0B\x=
0B\x01\x3B\x2A\x01\x0E\x0E\x01\x13\x07\x01\x3C\x28\x01\x13\x18\x01\x0B\x0=
A\x01\x3F\x01\x01\x50\x00\x01\x18\x00\x01\x40\x0E\x01\x20\x14\x01\x4B\x03=
\x01\x29\x05\x01\x44\x0C\x01\x00\x14\x01\x3C\x29\x
> 01
> \x25\x05\x01\x5F\x1B\x01\x32\x32\x01\x1A\x58\x01\x39\x4B\x01\x2D\x06\x0=
1\x3C\x02\x01\x3B\x3D\x01\x43\x49\x01\x48\x04\x01\x49\x03\x01\x50\x03\x01=
\x48\x05\x01\x38\x32\x01\x19\x0E\x01\x52\x64\x01\x4A\x04\x01\x25\x4B\x01\=
x4D\x0B\x01\x35\x01\x01\xF7";
>=20
> 	delay=3D(struct timespec *)malloc(sizeof(struct timespec));
> 		 	// definie le delai de 10ms
> 	delay->tv_sec=3D0;
> 	delay->tv_nsec=3D10000000;
> 	 	//envoie l'entete du sysex
> 	for (i=3D0;i<7;i++)
> 		snd_rawmidi_write (handle,&sysex[i],1);
> 	snd_rawmidi_drain(handle);
> 	 	flag=3D0;
> 	 	while (i!=3D308) {
> 		snd_rawmidi_write (handle,&sysex[i],1);
> 		i++;
> 		flag++;
> 		if (flag=3D=3D3) {
> 			nanosleep(delay,NULL);
> 			flag=3D0;
> 			snd_rawmidi_drain(handle);
> 		}
> 	}
> }
>=20
> void pc(int fd){
> 	 	// program change vers programme 0
> 	write (fd,"\xc0\x0",2);
> }
>=20
> void affiche(unsigned char a[]) {
> 	int i=3D-1;
> 	 	printf("SySex recu : \n");
> 	 	 	while (a[i++] !=3D 0xF7) {
> 		printf("%x",a[i]);
> 		printf(" ");
> 	}
> 	printf("\n");
> 	printf("\n");
> 	 	return;
> }
>=20
> void rp(snd_rawmidi_t *handle_in,snd_rawmidi_t *handle_out) {
> 	unsigned char buf[307];
> 	 	=20
> snd_rawmidi_write(handle_out,"\xF0\x00\x00\x0E\x12\x00\x41\xF7",8);
> 	snd_rawmidi_drain(handle_out);
> 	 	snd_rawmidi_read(handle_in,buf,308);
>=20
> 	affiche(buf);
>=20
> }
>=20
> int main (int argc,char **argv) {
> 	int fd;
> 	int err;
> 	snd_rawmidi_t *handle_in,*handle_out;
> 	char *device_in =3D NULL;
> 	char *device_out =3D NULL;
> 	 	//ouverture du node en lecture
> 	err =3D snd_rawmidi_open(&handle_in, NULL, device_in, 0);
> 	if (err)
> 		printf("snd_rawmidi_open IN a echoue...\n");
> 	 	//ouverture du node en lecture
> 	err =3D snd_rawmidi_open(NULL, &handle_out, device_out, 0);
> 	if (err)
> 		printf("snd_rawmidi_open OUT a echoue...\n");
> 	 	printf("Store\n");
> 	store(handle_out);
> 	 	sleep(1);
>     /*	printf("Dump Edit Buffer\n");
> 	deb(fd);
> 	 	sleep(1);*/
> 	 	printf("Dump All Data\n");
> 	dad(handle_out);
> 	 	sleep(1);
> 	 /*	printf("Program Change\n");
> 	pc(fd);
> 	 	sleep(1);*/
> 	 	printf("Request All Program\n");
> 	rp(handle_in,handle_out);
> 	 	sleep(1);
> 	 	return 0;
> }
>=20
> /* END OF SOURCE */
>=20
> First, it isn't well programmed, I know it ! In fact, I've programmed=20
> this one using nodes (/dev/midi), passing trough the rawmidi api. So=20
> in this source, you'll see trace of the old source... But now, I'm=20
> trying to use the rawmidi interface. This program compile well, but=20
> at execution, I could see this :
>=20
> 	api: rawmidi.c:301: snd_rawmidi_open: Assertion `(inputp ||=20
> outputp) && name' failed.
>=20
> (note : first word, api, is the name of my source)
>=20
> What's the problem ?
>=20
> This one has been tested on :
>=20
> 	linux 2.4.18
> 	very last alsa ! (Release Candidate 0.9 RC1)
> 	maestro3
> 	emu10k1 on another computer with same kernel and same alsa
>=20
> If anyone could help me, I'll be very very happy, and my teacher too=20
> !! (this project is for my studies...)
>=20
> Thanx for all !
>=20
> Charles
>=20
> _______________________________________________________________
>=20
> Have big pipes? SourceForge.net is looking for download mirrors. We=20
> supply
> the hardware. You get the recognition. Email Us:=20
> bandwidth@sourceforge.net
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
